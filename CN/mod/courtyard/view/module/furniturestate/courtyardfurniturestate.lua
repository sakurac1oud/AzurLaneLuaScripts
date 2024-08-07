slot0 = class("CourtyardFurnitureState")

slot0.Ctor = function(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._tf = slot1.transform
	slot0.rectTF = slot2
	slot0.rootTF = slot0._tf.parent
	slot0.furnitureStateImg = slot0._tf:GetComponent(typeof(Image))
	slot0.furnitureStateAnim = slot0._tf:GetComponent(typeof(Animation))
	slot0.selectedMat = slot3
	slot0.canPlaceMat = slot4
	slot0.cantPlaceMat = slot5
end

slot0.Init = function(slot0, slot1, slot2)
	slot3 = pg.UIMgr.GetInstance()

	slot3:LoadingOn(false)
	setActive(slot0._tf, false)

	slot3 = ResourceMgr.Inst

	slot3:getAssetAsync("furnitrues/" .. slot2:GetPicture(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function (slot0)
		pg.UIMgr.GetInstance():LoadingOff()

		if uv0.exited then
			return
		end

		setActive(uv0._tf, true)

		uv0.furnitureStateImg.sprite = slot0:GetComponent(typeof(Image)).sprite
		uv0._tf.sizeDelta = slot0.transform.sizeDelta
		uv0._tf.localPosition = uv1:GetCenterPoint()

		uv0:OnUpdateScale(uv1)
		uv0:OnReset()
	end), true, true)
end

slot0.OnInit = function(slot0, slot1, slot2)
	slot0:Init(slot1, slot2)
	setParent(slot0._tf, slot0.rectTF)
end

slot0.OnUpdateScale = function(slot0, slot1)
	slot0._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(slot1._tf.localScale.x), 1, 1)
end

slot0.OnUpdate = function(slot0, slot1)
	slot0._tf.localPosition = slot1:GetCenterPoint()
end

slot0.OnCantPlace = function(slot0)
	if slot0.furnitureStateImg.material ~= slot0.cantPlaceMat then
		slot0.furnitureStateImg.material = slot0.cantPlaceMat

		slot0.furnitureStateAnim:Play("anim_courtyard_iconred")
	end
end

slot0.OnCanPlace = function(slot0)
	if slot0.furnitureStateImg.material ~= slot0.canPlaceMat then
		slot0.furnitureStateImg.material = slot0.canPlaceMat

		slot0.furnitureStateAnim:Play("anim_courtyard_icongreen")
	end
end

slot0.OnReset = function(slot0)
	if slot0.furnitureStateImg.material ~= slot0.selectedMat then
		slot0.furnitureStateImg.material = slot0.selectedMat

		slot0.furnitureStateAnim:Play("anim_courtyard_iconwhite")
	end
end

slot0.OnClear = function(slot0)
	slot0.furnitureStateAnim:Stop()

	slot0.furnitureStateImg.sprite = nil
	slot0.furnitureStateImg.material = nil

	setParent(slot0._tf, slot0.rootTF)
end

return slot0
