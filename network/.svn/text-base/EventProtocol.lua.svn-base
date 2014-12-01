
local EventProtocol = {}

--function EventProtocol.extend(object)

EventProtocol.extend = function(object)
    object.listeners_ = {}
    object.listenerHandleIndex_ = 0
    
    function object:addSocketEventListener(eventName, listener, target)
    print("成功啦成功啦")
        object.listenerHandleIndex_ = object.listenerHandleIndex_ + 1
        local tb = {eventName = eventName,listener=listener}
        table.insert(object.listeners_,tb)
    end
    
    function object:dispatchEvent(event)
        for i, v in ipairs(object.listeners_) do
            if v.eventName == event then
                return v.listener()
    	   end
        end

    end
   
    function object:removeEventListener(eventName)
        for i, v in ipairs(object.listeners_) do
            if v.eventName == eventName then
                table.remove(object.listeners_,v)
            end
        end
    end
        
    function object:removeAllEventListeners()
        object.listeners_ = {}
    end 
end
return EventProtocol