
local function pre_process(msg)
chat = msg.chat_id_
user = msg.sender_user_id_
	local function check_newmember(arg, data)
		test = load_data(_config.moderation.data)
		lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, '💡¦ *User* ['..user_name..'] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is banned*', 0, "md")
   else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, '💡¦ _العضو_ ['..user_name..'] \n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تم حظره_ ✔', 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is globally banned*', 0, "md")
    else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, '💡¦ _العضو_ ['..user_name..'] \n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تم الحظر العام عليه_ ✔', 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
	end
	if msg.adduser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end
	if msg.joinuser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end
if is_silent_user(user, chat) then
del_msg(msg.chat_id_, msg.id_)
end
if is_banned(user, chat) then
del_msg(msg.chat_id_, tonumber(msg.id_))
    kick_user(user, chat)
   end
if is_gbanned(user) then
del_msg(msg.chat_id_, tonumber(msg.id_))
    kick_user(user, chat)
   end
end
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "ban" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can't ban mods,owners and bot admins*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك حظر (المدير,الادمنية) ❌_", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ]\n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is already banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه بلفعل محظور_ ✔', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *has been banned*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه حظره بنجاح_ ✔', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is not banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه بلفعل ليس محظور_ ❌', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *has been unbanned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تم رفع الحظر عنه_ ❌', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You [can't silent] mods,owners and bot admins*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك تفعيل الصامت على(المدير,الادمنية) ❌_", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *is already silent*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه بلفعل مكتوم_ ✔', 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *added to silent user list*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تمت اضافته الى قائمة الكتم_ ✔', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *is not silent*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه ليس من المكتومين_ ❌', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *removed to silent list*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تمت ازالته من قائمة الكتم_ ❌', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can't globally ban other admins*", 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك تفعيل الحظر العام على(المدير,الادمنية) ❌_", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *is already globally banned*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه بلفعل محظور عام_ ✔', 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *has been globally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم اضافته الى الحظر العام_ ✔', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *is not globally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه ليس محظور عام_ ❌', 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *has been unglobally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم رفع الحظر العام عنه_ ❌', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "kick" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *You can't kick mods,owners and bot admins*", 0, "md")
    elseif lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك طرد على(المدير,الادمنية) ❌_", 0, "md")
   end
  else
     kick_user(data.sender_user_id_, data.chat_id_)
     end
  end
  if cmd == "delall" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *You can't delete messages mods,owners and bot admins*", 0, "md")
   elseif lang then
return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ _عذراً لا يمكن طرد (المدراء,الادمنية)_ ❌", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, '💡¦ *All messages of* *[ '..data.sender_user_id_..' ]* \n💡¦ *has been deleted*', 0, "md")
      elseif lang then
return tdcli.sendMessage(data.chat_id_, "", 0, '💡¦ _رسائل العضو _*[ '..data.sender_user_id_..' ]* \n💡¦ _تم مسحها جميعها_ ✔', 0, "md")
       end
    end
  end
else
    if lang then
return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ _لا يوجد هذا العضو_ ❌", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *User Not Found* ❌", 0, "md")
      end
   end
end
local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "ban" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can't ban mods,owners and bot admins*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك حظر (المدير,الادمنية) ❌_", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is already banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه بلفعل محظور_ ✔', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *has been banned*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم تفعيل الحظر عليه_ ✔', 0, "md")
   end
end
   if cmd == "unban" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *is not banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه ليس محظور_ ❌', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ]* \n💡¦ *has been unbanned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم رفع الحظر عنه_ ❌', 0, "md")
   end
end
  if cmd == "silent" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can't silent mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك تفعيل الصامت على(المدير,الادمنية) ❌_", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *is already silent*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه بلفعل مكتوم_ ✔', 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *added to silent user list*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تمت اضافته الى قائمة الكتم_ ✔', 0, "md")
   end
end
  if cmd == "unsilent" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *is not silent*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _انه ليس من المكتومين_ ❌', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] *[ '..data.id_..' ]* \n💡¦ *removed fro silent user list*', 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ]\n💡¦ _الايدي_ *[ '..data.id_..' ]* \n💡¦ _تمت ازالته من قائمة الكتم_ ❌', 0, "md")
   end
end
  if cmd == "banall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can,t globally ban other admins*", 0, "md")
  else
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك تفعيل الحظر العام على(المدير,الادمنية) ❌_", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *is already globally banned*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه بلفعل محظور عام_ ✔', 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *has been globally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم اضافته الى الحظر العام_ ✔', 0, "md")
   end
end
  if cmd == "unbanall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *is not globally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _انه ليس محظور عام_ ❌', 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* [ '..user_name..' ] \n💡¦ *ID* *[ '..data.id_..' ] * \n💡¦ *has been unglobally banned*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _العضو_ [ '..user_name..' ] \n💡¦ _الايدي_ *[ '..data.id_..' ] * \n💡¦ _تم رفع الحظر العام عنه_ ❌', 0, "md")
   end
end
  if cmd == "kick" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can,t kick mods,owners and bot admins*", 0, "md")
    elseif lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك طرد على(المدير,الادمنية) ❌_", 0, "md")
   end
  else
     kick_user(data.id_, arg.chat_id)
     end
  end
  if cmd == "delall" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *You can,t delete messages mods,owners and bot admins*", 0, "md")
   elseif lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _عذراً لا يمكنك مسح رسائل على(المدير,الادمنية) ❌_", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *All messages of* [ '..user_name..' ]\n💡¦ *ID* *[ '..data.id_..' ]*\n💡¦ *has been deleted*', 0, "md")
      elseif lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ _رسائل العضو_ [ '..user_name..' ]\n💡¦ *ID* *[ '..data.id_..' ]*\n💡¦ _تم مسحها بنجاح _✔', 0, "md") --by @mmff1
       end
    end
  end
else
    if lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ _لا يوجد هذا العضو_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *User Not Found*", 0, "md")
      end
   end
end
local function run(msg, matches)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
chat = msg.chat_id_
user = msg.sender_user_id_
 if matches[1] == "kick" or matches[1] == "طرد" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="kick"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
     tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ *You can't kick mods,owners or bot admins*", 0, "md")
   elseif lang then
tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ _عذراً لا يمكنك طرد(المدراء,الادمنية)_ ❌", 0, "md")
         end
     else
kick_user(matches[2], msg.chat_id_)
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="kick"})
         end
      end
 if matches[1] == "delall"or matches[1] == "مسح الرسائل"  and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="delall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ *You can't delete messages mods,owners or bot admins*", 0, "md")
     elseif lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ _لا يمكنك مسح رسائل (المدير,الادمن)_ ❌", 0, "md")
   end
     else
tdcli.deleteMessagesFromUser(msg.chat_id_, matches[2], dl_cb, nil)
    if not lang then
  return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *All messages of* *[ '..matches[2]..' ]*\n💡¦ *has been deleted*', 0, "md")
   elseif lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _رسائل العضو_ *[ '..matches[2]..' ]*\n💡¦ _تم مسحها بنجاح_ ✔', 0, "md")
         end
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="delall"})
         end
      end
 if matches[1] == "banall" or matches[1] == "حظر عام" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="banall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_admin1(matches[2]) then
   if not lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ *You can,t globally ban other admins*", 0, "md")
else
return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ _لا تستطيع رفعيل الحظر العام على (المدراء,الادمنية)_", 0, "md")
        end
     end
   if is_gbanned(matches[2]) then
   if not lang then
  return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦*User* [ '..matches[2]..' ]\n💡¦ *is already globally banned*', 0, "md")
    else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل محظور عام_ ✔', 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.chat_id_)
   if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦*User* '..matches[2]..' ] \n💡¦ *has been globally banned*', 0, "md")
    else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ '..matches[2]..' ] \n💡¦ _تمت اضافته الى الحظر العام_ ✔', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="banall"})
      end
   end
 if matches[1] == "unbanall" or matches[1] == "الغاء العام" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="unbanall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
     if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *User* [ '..matches[2]..' ] \n💡¦ *is not globally banned*', 0, "md")
    else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل ليس محظور_ ❌', 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦*User* '..matches[2]..' ] \n💡¦ *has been globally unbanned*', 0, "md")
   else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ '..matches[2]..' ] \n💡¦ _تمت الغاء الحظر العام عنه_ ❌', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="unbanall"})
      end
   end
 if matches[1] == "ban" or matches[1] == "حظر" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="ban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
     if not lang then
    return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ *You can,t ban mods,owners or bot admins*", 0, "md")
    else
return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ _لا تستطيع تفعيل الحظر على (المدراء,الادمنية) _❌", 0, "md")
        end
     end
   if is_banned(matches[2], msg.chat_id_) then
   if not lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *User* [ '..matches[2]..' ] \n💡¦ *is already banned*', 0, "md")
  else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل محظور_ ❌', 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.chat_id_)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦*User* '..matches[2]..' ] \n💡¦ *has been banned*', 0, "md")
  else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ '..matches[2]..' ] \n💡¦ _تمت حظره بنجاح_ ❌', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="ban"})
      end
   end
 if matches[1] == "unban" or matches[1] == "الغاء الحظر" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="unban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.chat_id_) then
   if not lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *User* [ '..matches[2]..' ] \n💡¦ *is not banned*', 0, "md")
  else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل ليس محظور عام_ ❌', 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦*User* '..matches[2]..' ] \n💡¦ *has been unbanned*', 0, "md")
   else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ '..matches[2]..' ] \n💡¦ _تمت الغاء الحظر عنه_ ❌', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="unban"})
      end
   end
 if matches[1] == "silent" or matches[1] == "كتم" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ *You can,t silent mods,leaders or bot admins*", 0, "md")
 else
return tdcli.sendMessage(msg.chat_id_, "", 0, "💡¦ _لا تستطيع كتم (المدراء,الادمنية) _❌", 0, "md")
        end
     end
   if is_silent_user(matches[2], chat) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *User* [ '..matches[2]..' ] \n💡¦ *is already silent*', 0, "md")
   else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل ضمن المكتومين_ ❌', 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
    if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ *User* [ '..matches[2]..' ]\n💡¦ *added to silent users list*', 0, "md")
  else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _تم تفعيل الصامت عليه_ ✔', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="silent"})
      end
   end
 if matches[1] == "unsilent" or matches[1] == "الغاء الكتم" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
     if not lang then
     return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ *User* [ '..matches[2]..' ]\n💡¦ *is not silent*', 0, "md")
   else
return tdcli.sendMessage(msg.chat_id_, "", 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _انه بلفعل ليس ضمن المكتومين_ ❌', 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ *User* [ '..matches[2]..' ]\n💡¦ *removed from silent users list*', 0, "md")
  else
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, '💡¦ _العضو_ [ '..matches[2]..' ]\n💡¦ _تم الغاء الصامت عنه_ ❌', 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="unsilent"})
      end
   end
		if matches[1]:lower() == 'clean' or matches[1]:lower() == 'مسح' and is_owner(msg) then
			if matches[2] == 'bans' or matches[2] == 'قائمة الحظر' then
				if next(data[tostring(chat)]['banned']) == nil then
     if not lang then
					return "💡¦ *No banned users in this group* ❌"
   else
					return "💡¦ _لا يوجد محظورين ليتم مسحهم_ ❌"
              end
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
     if not lang then
				return "💡¦ *All banned users has been unbanned* ✔"
    else
				return "💡¦ _ تم حذف جميع المحظورين_ ✔"
           end
			end
			if matches[2] == 'silentlist' or matches[2] == 'قائمة المكتومين' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
        if not lang then
					return "💡¦ *No silent users in this group*"
   else
					return "💡¦ _لا يوجد مكتومين ليتم مسحهم_ ❌"
             end
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
       if not lang then
				return "💡¦ *Silent list has been cleaned*"
   else
				return "💡¦ _تم حذف جميع المكتومين_ ✔"
               end
			    end
        end
		if matches[1]:lower() == 'clean' or matches[1]:lower() == 'مسح' and is_sudo(msg) then
			if matches[2] == 'gbans' or matches[2] == 'قائمة العام' then
				if next(data['gban_users']) == nil then
    if not lang then
					return "💡¦ *No globally banned users available*"
   else
					return "💡¦ _لا يوجد محظورين عام ليتم حذفهم_ ❌"
             end
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
      if not lang then
				return "💡¦ *All globally banned users has been unbanned*"
   else
				return "💡¦ _تم حذف جميع المحظورين عام_ ✔"
          end
			end
     end
if matches[1] == "gbanlist" or matches[1] == "قائمة العام" and is_admin(msg) then
  return gbanned_list(msg)
 end
if matches[1] == "silentlist" or matches[1] == "قائمة الكتم" and is_mod(msg) then
  return silent_users_list(chat)
 end
if matches[1] == "banlist" or matches[1] == "قائمة الحظر" and is_mod(msg) then
  return banned_list(chat)
 end
end
return {
	patterns = {
		"^[!/#](banall)$",
		"^[!/#](banall) (.*)$",
		"^[!/#](unbanall)$",
		"^[!/#](unbanall) (.*)$",
		"^[!/#](gbanlist)$",
		"^[!/#](ban)$",
		"^[!/#](ban) (.*)$",
		"^[!/#](unban)$",
		"^[!/#](unban) (.*)$",
		"^[!/#](banlist)$",
		"^[!/#](silent)$",
		"^[!/#](silent) (.*)$",
		"^[!/#](unsilent)$",
		"^[!/#](unsilent) (.*)$",
		"^[!/#](silentlist)$",
		"^[!/#](kick)$",
		"^[!/#](kick) (.*)$",
		"^[!/#](delall)$",
		"^[!/#](delall) (.*)$",
		"^[!/#](clean) (.*)$",
		"^(حظر عام)$",
		"^(حظر عام) (.*)$",
		"^(الغاء العام)$",
		"^(الغاء العام) (.*)$",
		"^(قائمة العام)$",
		"^(حظر)$",
		"^(حظر) (.*)$",
		"^(الغاء الحظر)$",
		"^(الغاء الحظر) (.*)$",
		"^(قائمة الحظر)$",
		"^(كتم)$",
		"^(كتم) (.*)$",
		"^(الغاء الكتم)$",
		"^(الغاء الكتم) (.*)$",
		"^(قائمة الكتم)$",
		"^(طرد)$",
		"^(طرد) (.*)$",
		"^(مسح الرسائل)$",
		"^(مسح الرسائل) (.*)$",
		"^(مسح) (.*)$",
	},
	run = run,
pre_process = pre_process
}

--by @mmff1
--ch @c9_pro
