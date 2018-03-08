
syn match UsualfilesComment /^\s*#.*/
syn match UsualfilesLine /^[^ \t#].*/
syn match UsualfilesMapping /^\S\+/ contained containedin=UsualfilesLine
syn match UsualfilesTarget /\t\+\zs.*/ contained containedin=UsualfilesLine

