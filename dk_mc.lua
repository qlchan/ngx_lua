-- dk_mc  service

local memcached = require("resty.memcached") or require("memcached")

_STATISTICS = {}

function _STATISTICS.connect( host, port )
    local memc,err = memcached:new()
    if not memc then
      --  ngx.say("failed to instantiate memc:" ,err)
      --  ngx.exit(404)
        return
    end
    memc:set_timeout(20000)
    if ( host == nil )  then
     -- ngx.say('host is empty')
     -- ngx.exit(404)
      return
    end
    local ok ,err = memc:connect( host , port )
    if not ok then
--      ngx.say("failed to connect:",err)
--      ngx.exit(200)
        return
     else
        return memc
     end
         
end
---get data from memcache

function _STATISTICS.getDataFromMemc( args )
   local memc = _STATISTICS.connect( args.host, args.port ) 
   local res,flags,err =   memc:get( args.key )
   if not res  then
      return res
   end
end

--set data into memcache

function _STATISTICS.setDataIntoMemc( args )
   local memc = _STATISTICS.connect( args.host, args.port )
   memc:set( args.key , args.value )   
end


return _STATISTICS
