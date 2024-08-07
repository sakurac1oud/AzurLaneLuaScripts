slot0 = class("Dorm3dFurnitureSelectMediator", import("view.base.ContextMediator"))
slot0.SHOW_CONFIRM_WINDOW = "SHOW_CONFIRM_WINDOW"
slot0.SHOW_FURNITURE_ACESSES = "SHOW_FURNITURE_ACESSES"

slot0.register = function(slot0)
	slot0:bind(GAME.APARTMENT_REPLACE_FURNITURE, function (slot0, slot1)
		uv0:sendNotification(GAME.APARTMENT_REPLACE_FURNITURE, slot1)
	end)
	slot0:bind(uv0.SHOW_CONFIRM_WINDOW, function (slot0, slot1)
		uv0:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureConfirmWindowMediator,
			viewComponent = Dorm3dFurnitureConfirmWindow,
			data = slot1
		}))
	end)
	slot0:bind(uv0.SHOW_FURNITURE_ACESSES, function (slot0, slot1)
		uv0:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureAcessesWindowMediator,
			viewComponent = Dorm3dFurnitureAcessesWindow,
			data = slot1
		}))
	end)

	slot2 = pg.m02:retrieveMediator(Dorm3dSceneMediator.__cname):getViewComponent()

	slot0.viewComponent:SetSceneRoot(slot2)
	slot0.viewComponent:SetApartment(slot2:GetApartment())
end

slot0.listNotificationInterests = function(slot0)
	return {
		Dorm3dSceneMediator.ON_CLICK_FURNITURE_SLOT,
		GAME.APARTMENT_REPLACE_FURNITURE_DONE,
		GAME.APARTMENT_REPLACE_FURNITURE_ERROR
	}
end

slot0.handleNotification = function(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == ApartmentProxy.UPDATE_APARTMENT then
		-- Nothing
	elseif slot2 == Dorm3dSceneMediator.ON_CLICK_FURNITURE_SLOT then
		slot0.viewComponent:OnClickFurnitureSlot(slot3)
	elseif slot2 == GAME.APARTMENT_REPLACE_FURNITURE_DONE then
		slot0.viewComponent:OnReplaceFurnitureDone()
	elseif slot2 == GAME.APARTMENT_REPLACE_FURNITURE_ERROR then
		slot0.viewComponent:OnReplaceFurnitureError()
	end
end

slot0.remove = function(slot0)
end

return slot0
