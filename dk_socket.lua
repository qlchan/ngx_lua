--基于socket 通信  
--
--ngx.socket.udp
--
--

_SOCKET  = { udpsock = nil }
---connect  udp

function _SOCKET.connectUdp( host, port)
     _SOCKET.udp = { host, port }
     local udpsock = ngx.socket.udp()
     local ok, err = udpsock:setpeername( host, port )
     if not ok then
         ngx.say("failed to connect to log server with udp ", err)
     end
     _SOCKET.settimeout( 3000 ) 
     _SOCKET.udpsock = udpsock
end

-- send data
--

function _SOCKET.send( line )
    if _SOCKET.udpsock then
        local udpsock = _SOCKET.udpsock
        if udpsock then
            local ok, err = udpsock:send(line)
            if  not ok then
            --    ngx.header.content_type = 'text/plain'
                ngx.say("send to udpsock failed", err)
             --   ngx.exit(200)
            end
        end
    end
end

-- timeout 设置
--
function _SOCKET.settimeout( time )
    if _SOCKET.udpsock then
        local udpsock = _SOCKET.udpsock
        udpsock:settimeout( time )
    end
end



return _SOCKET
