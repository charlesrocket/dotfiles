#!/usr/bin/env nu

# Recursive file looter:
# loot-files ./data dump.txt -m "### {filename}" -i "cache,.tmp,*.log"

def glob-to-regex [pat: string] {
    let body = (
        $pat
        | str replace --all --regex '([.+^$(){}|\\\[\]])' '\$1'
        | str replace --all '*' '.*'
        | str replace --all '?' '.'
    )

    "^" ++ $body ++ "$"
}

def main [
    source_dir: path # target directory to scan
    output_file: path # output file
    --marker(-m): string = "///////// {filename}" # marker
    --ignore(-i): string = "" # exclusion pattern
] {
    let src = $source_dir | path expand

    if ($src | path type) != "dir" {
        error make {msg: $"($src) is not a directory"}
    } else {
        print $"[(ansi purple_bold)CHECKS(ansi reset)] done"
    }

    let out = $output_file | path expand
    let matchers = (
        $ignore
        | split row ','
        | each {|p| $p | str trim }
        | where {|p| $p != "" }
        | each { |p|
            {
                pat: $p
                wild: (($p | str contains "*") or ($p | str contains "?"))
                re: (glob-to-regex $p)
            }
        }
    )

    "" | save --force $out

    let all_files = (do {
        cd $src
        glob "**/*" --no-dir
    } | sort)

    mut looted = 0
    mut skipped = 0
    mut errored = 0

    for abs in $all_files {
        let rel = $abs | path relative-to $src

        if ($abs | path expand) == $out {
            continue
        }

        let parts = $rel | path split
        let ignored = ($matchers | any { |m|
            if $m.wild {
                $parts | any {|c| $c =~ $m.re }
            } else {
                $parts | any {|c| $c == $m.pat }
            }
        })

        if $ignored {
            print $"[(ansi yellow_bold)NOLOOT(ansi reset)] ($rel)"
            $skipped += 1
            continue
        }

        let raw = (
            try {
                open --raw $abs
            } catch {|e|
                print $"[!(ansi red_bold)ERROR(ansi reset)] ($rel): ($e.msg)"
                null
            }
        )

        if ($raw | describe) == "string" {
            let marker_text = $marker | str replace --all "{filename}" $rel
            $"($marker_text)\n($raw)\n" | save --append $out
            print $"[(ansi green_bold)LOOTED(ansi reset)] ($rel)"
            $looted += 1
        } else {
            if $raw != null {
                print $"[BINARY] ($rel)"
                $skipped += 1
            } else {
                $errored += 1
            }
        }
    }

    print $"[(ansi purple_bold)FINISH(ansi reset)] looted=($looted) skipped=($skipped) errors=($errored)"
    print $"[(ansi purple_bold)OUTPUT(ansi reset)] ($out)"

    if $errored > 0 { exit 1 }
}
