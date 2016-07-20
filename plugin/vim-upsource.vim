" first comment
function! GetDate(format)
  let format = empty(a:format) ? '+%A %Y-%m-%d %H:%M UTC' : a:format
  let cmd = '/bin/date -u ' . shellescape(format)
  let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
  " Append space + result to current line without moving cursor.
  call setline(line('.'), getline('.') . ' ' . result)
endfunction

" parse json command
" sed 's/\\\\\//\//g' | 
" sed 's/[{}]//g' | 
" awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | 
" sed 's/\"\:\"/\|/g' | 
" sed 's/[\,]/ /g' |
" sed 's/\"//g'
function! GetUpsourceProjectId()
    let hash = system("git log -1 --format=\"%H\"")
    let proc = " awk -F\"[,:}]\" '{for(i=1;i<=NF;i++){if($i~/\042'projectId'\042/){print $(i+1)}}}' | tr -d '\"' | sed -n ${num}p | head -1"
    let req  =  " '{\"commits\" : {\"revisionId\" : \"". hash . "\"} }' "
    let url  =  " https://upsource.tools.russianpost.ru/~rpc/findCommits "
    let cmd = 'curl -s --user aponkin:JPWWh2u9Kz -i -X POST -d' . req . url . "|" . proc
    let res = system(cmd)
    echo res
endfunction

" awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/\042'$KEY'\042/){print $(i+1)}}}'
" | tr -d '"' | sed -n ${num}p
