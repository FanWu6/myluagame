require "src/network/NetDATA"
function XMLhttpRequestInit(contact_panel,EditName,EditPassword,SceneMainLogIn)

    local function contactShow()
        contact_panel:setVisible(true)

    end
    local function contactNotShow()
        contact_panel:setVisible(false)
    end
    
        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        print("timeout=="..xhr.timeout)
        --            local u=EditName:getText()
        --            
        --            local p=EditPassword:getText()
        local u="ahwwl"
        local p="ahwwl"
        local t=os.time()
        local k="abcd"
        local md5 = md5String(u..p..t..k)
        --            xhr:open("GET","http://192.168.0.81/users.php?u="..EditName:getText().."&p="..EditPassword:getText()..md5String(EditName:getText().."123456".."abcd"))
        
        xhr:open("GET",HTTP_LOGIN_URL..u.."&t="..t.."&toten="..md5)
--            xhr:open("GET","http://httpbin.org/get")
        
        print(HTTP_LOGIN_URL..u.."&t="..t.."&toten="..md5String(u..p..t.."abcd"))
        local function onReadyStateChange()
            local statusString = "Http Status Code:"..xhr.statusText
            print(statusString)
            print(xhr.response)
            contactNotShow()
        
            if tonumber(xhr.response)>0 then
            NETWORD_DATA["HTTP_USER_ID"] = tonumber(xhr.response)
                SceneMainLogIn()
            end
        end
        
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()
        
        print("waiting...")
        contactShow()
end