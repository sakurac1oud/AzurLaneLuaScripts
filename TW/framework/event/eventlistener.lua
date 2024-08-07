ys = ys or {}
slot0 = ys
slot0.EventListener = class("EventListener")
slot0.EventListener.__name = "EventListener"

slot0.EventListener.AttachEventListener = function(slot0)
	uv0.EventListener.New(slot0)
end

slot0.EventListener.DetachEventListener = function(slot0)
	if slot0._eventListener_ == nil then
		return
	end

	slot0._eventListener_:_Destory_()

	slot0._eventListener_ = nil
end

slot0.EventListener.Ctor = function(slot0, slot1)
	slot0._target_ = slot1
	slot0._target_._eventListener_ = slot0
	slot0._routeMap_ = {}
end

slot0.EventListener._Destory_ = function(slot0)
	slot0._routeMap_ = nil
	slot0._target_ = nil
end

slot0.EventListener._AddRoute_ = function(slot0, slot1, slot2, slot3)
	if slot0._routeMap_[slot1] == nil then
		slot0._routeMap_[slot1] = {}
	end

	slot0._routeMap_[slot1][slot2] = slot3
end

slot0.EventListener._RemoveRoute_ = function(slot0, slot1, slot2)
	slot0._routeMap_[slot1][slot2] = nil
end

slot0.EventListener._Handle_ = function(slot0, slot1)
	slot0._routeMap_[slot1.ID][slot1.Dispatcher](slot0._target_, slot1)
end
