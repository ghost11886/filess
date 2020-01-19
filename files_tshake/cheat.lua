
local function Num_Msg(data)
local msg = data.message_
text = msg.content_.text_
local function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = disable_web_page_preview,clear_draft_ = 0,entities_ = {},parse_mode_ = {ID = "TextParseModeMarkdown"},},}, dl_cb, nil)
end
------------------------------------------------------------------------
--// استقبال الرسائل
if database:get('tshake:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del('tshake:'..bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, 1, "\n📮┇ تم الغاء الامر ", 1, "md") 
database:del('tshake:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del('tshake:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get('tshake:'..bot_id..'id:user'..msg.chat_id_)  
database:incrby('tshake:'..bot_id..'nummsg'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "\n📥┇تم اضافة له {"..numadded..'} من الرسائل', 1, 'md')  
end
------------------------------------------------------------------------
if database:get('tshake:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del('tshake:'..bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, 1, "\n📮┇ تم الغاء الامر ", 1, "md") 
database:del('tshake:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del('tshake:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get('tshake:'..bot_id..'idgem:user'..msg.chat_id_)  
database:incrby('tshake:'..bot_id..'add:num'..msg.chat_id_..iduserr,numadded)  
database:incrby('tshake:'..bot_id..'add:numall'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "\n📥┇تم اضافة له {"..numadded..'} من المجوهرات', 1, 'md')  
end
------------------------------------------------------------
if is_devabas(msg) or is_sudo(msg) or is_creatorbasic(msg) or is_creatorbasicc(msg.chat_id_,msg.sender_user_id_) or is_creatorr(msg.chat_id_,msg.sender_user_id_) or is_creator(msg) and ChekAdd(msg.chat_id_) == true then
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 then    
taha = text:match("^اضف رسائل (%d+)$")
database:set('tshake:'..bot_id..'id:user'..msg.chat_id_,taha)  
database:setex('tshake:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
local t = '✉┇ارسل لي عدد الرسائل الان'  
send(msg.chat_id_, msg.id_, 1,t, 1, 'md') 
end
------------------------------------------------------------------------
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ == 0 then  
taha = text:match("^اضف مجوهرات (%d+)$")
database:set('tshake:'..bot_id..'idgem:user'..msg.chat_id_,taha)  
database:setex('tshake:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
local t = '💠┇ارسل لي عدد المجوهرات الان'  
send(msg.chat_id_, msg.id_, 1,t, 1, 'md') 
end
end
------------------------------------------------------------------------
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ ~= 0 then
local Num = text:match("^اضف مجوهرات (%d+)$")
function reply(extra, result, success)
database:incrby('tshake:'..bot_id..'add:num'..msg.chat_id_..result.sender_user_id_,Num)  
database:incrby('tshake:'..bot_id..'add:numall'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,  1, "\n📥┇تم اضافة له {"..Num..'} من المجوهرات', 1, 'md')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:incrby('tshake:'..bot_id..'nummsg'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,  1, "\n📥┇تم اضافة له {"..Num..'} من الرسائل', 1, 'md')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------
end
return {keko_tshake = Num_Msg,}
