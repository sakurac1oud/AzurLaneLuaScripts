slot0 = class("GuildSendMsgCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	pg.ConnectionMgr.GetInstance():Send(60007, {
		chat = slot1:getBody()
	})
end

return slot0
