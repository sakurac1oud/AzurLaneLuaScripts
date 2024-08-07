slot0 = class("GuildRankPage", import("...base.GuildBasePage"))

slot0.getTargetUI = function(slot0)
	return "GuildRankBluePage", "GuildRankRedPage"
end

slot1 = {
	"commit",
	"task",
	"battle"
}
slot2 = {
	i18n("guild_member_rank_title_donate"),
	i18n("guild_member_rank_title_finish_cnt"),
	i18n("guild_member_rank_title_join_cnt")
}

slot0.PageId2RankLabel = function(slot0)
	return uv0[slot0]
end

slot0.GetRank = function(slot0, slot1)
	return slot0.ranks[slot1]
end

slot0.OnUpdateRankList = function(slot0, slot1, slot2)
	if slot2 and table.getCount(slot2) > 0 then
		slot0.ranks[slot1] = slot2

		if slot0.pageId == slot1 then
			slot0:SwitchPage(slot1)
		end
	end
end

slot0.OnLoaded = function(slot0)
	slot0.tabContainer = slot0:findTF("frame/bg/tab")
	slot0.ranTypeTF = slot0:findTF("frame/bg/week")
	slot0.closeBtn = slot0:findTF("frame/close")
	slot0.rankLabel = slot0:findTF("frame/bg/title/Text"):GetComponent(typeof(Text))
	slot0.scrollrect = slot0:findTF("frame/bg/scrollrect"):GetComponent("LScrollRect")

	slot0.scrollrect.onUpdateItem = function(slot0, slot1)
		uv0:OnUpdateItem(slot0, slot1)
	end

	setActive(slot0.ranTypeTF:Find("month"), true)
	setActive(slot0.ranTypeTF:Find("total"), true)
end

slot0.OnInit = function(slot0)
	onButton(slot0, slot0._tf, function ()
		uv0:Hide()
	end, SFX_PANEL)
	onButton(slot0, slot0.closeBtn, function ()
		uv0:Hide()
	end, SFX_PANEL)

	slot0.ranType = 0

	onButton(slot0, slot0.ranTypeTF, function ()
		uv0.ranType = (uv0.ranType + 1) % 3

		uv1()
	end, SFX_PANEL)
	slot0:InitTags()
	(function ()
		if uv0.pageId then
			uv0:SwitchPage(uv0.pageId)
		end

		uv0.ranTypeTF:Find("month"):GetComponent(typeof(Image)).enabled = uv0.ranType == 0
		uv0.ranTypeTF:Find("total"):GetComponent(typeof(Image)).enabled = uv0.ranType == 2
		uv0.ranTypeTF:GetComponent(typeof(Image)).enabled = uv0.ranType == 1
	end)()
end

slot0.InitTags = function(slot0)
	for slot4, slot5 in ipairs(uv0) do
		slot6 = slot0.tabContainer

		onToggle(slot0, slot6:Find(slot5), function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)
			end
		end, SFX_PANEL)
	end
end

slot0.Flush = function(slot0, slot1)
	slot0.ranks = slot1

	pg.UIMgr.GetInstance():BlurPanel(slot0._tf)
	slot0:Show()
	slot0._tf:SetAsLastSibling()
	triggerToggle(slot0.tabContainer:Find("commit"), true)
end

slot0.SwitchPage = function(slot0, slot1)
	slot0.pageId = slot1

	slot0.scrollrect:SetTotalCount(0)

	if not slot0:GetRank(slot1) or getProxy(GuildProxy):ShouldRefreshRank(slot1) then
		slot0:emit(GuildMemberMediator.GET_RANK, slot1)
	else
		assert(slot2)
		slot0:InitRank(slot2)
	end

	slot0.rankLabel.text = uv0.PageId2RankLabel(slot1)
end

slot0.InitRank = function(slot0, slot1)
	slot0.displays = {}

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.displays, slot6)
	end

	table.sort(slot0.displays, function (slot0, slot1)
		return slot1:GetScore(uv0.ranType) < slot0:GetScore(uv0.ranType)
	end)
	slot0.scrollrect:SetTotalCount(#slot0.displays)
end

slot0.OnUpdateItem = function(slot0, slot1, slot2)
	slot3 = slot0.displays[slot1 + 1]

	setText(tf(slot2):Find("number"), slot1 + 1)
	setText(tf(slot2):Find("name"), slot3:GetName())
	setText(tf(slot2):Find("score"), slot3:GetScore(slot0.ranType))
end

slot0.Hide = function(slot0)
	if slot0:isShowing() then
		pg.UIMgr.GetInstance():UnblurPanel(slot0._tf, slot0._parentTf)
	end

	uv0.super.Hide(slot0)
end

slot0.OnDestroy = function(slot0)
	slot0:Hide()
end

return slot0
