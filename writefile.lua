    local rid = pid .. zid 
    local yyyymm = os.date('%Y%m')
    local yyyymmdd = os.date('%Y%m%d')
    local ts = getClientTs()

    local logpath

    if logtype == 1 then
        logpath = "/data/syslog/platformlog/" .. yyyymm .. "/login_".. pid .. "_" .. rid .. "_" .. yyyymmdd .. ".log"
    elseif logtype == 2 then
        logpath = "/data/syslog/platformlog/" .. yyyymm .. "/active_".. pid .. "_" .. rid .. "_" .. yyyymmdd .. ".log"
    else
        logpath = "/data/syslog/platformlog/" .. yyyymm .. "/activesuccess_".. pid .. "_" .. rid .. "_" .. yyyymmdd .. ".log"
    end

    table.insert(logtext,pid)
    table.insert(logtext,rid)

    logtext = table.concat(logtext,"\t") .. '\r\n'
    local f = io.open(logpath, "a+")
    if f then
        f:write(logtext)
        f:close()
    end
