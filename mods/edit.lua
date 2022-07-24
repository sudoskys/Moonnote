
require "import"

import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--通知
import "android.content.Context"
import "android.content.Intent"
import "android.app.PendingIntent"
import "android.app.Notification"
import"mods.runbase"
import "java.io.File"

import"values.base"
import"values.edit_select"
activity.setTitle('编辑页')

import "com.dingyi.dialog.BottomDialog"
md=require "mods.luaMarkdown"

import"mods.ioshare"
roadt=...

activity.ActionBar.hide()--隐藏标题栏

path=tostring(roadt)
create_time=StrToTable(io.open(path):read("*a"))["date"]["create"]
after_c=string.gsub(StrToTable(io.open(path):read("*a"))["content"]["messages"],":xjszkh:","[")
after_c=string.gsub(after_c,":xjsykh:","]")
card_color=StrToTable(io.open(path):read("*a"))["content"]["color"] or -1
note_category=StrToTable(io.open(path):read("*a"))["content"]["category"] or "记事"
isStared=StrToTable(io.open(path):read("*a"))["content"]["star"] or false
titles=getActuallyTitle(StrToTable(io.open(tostring(path)):read("*a"))["content"]["title"])

set_flagcolor(to0x(maincolor))
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出
activity.setContentView(loadlayout("layout/edit"))
FakeBold(edit_title)


if isStared==true then
  editout.addView(loadlayout(contentcode))
 else
  editout.addView(loadlayout(contentpage))
end

note_title.setText(titles)
note_content.setText(after_c)


ripples(back,to0x(sancolor))
ripples(review,to0x(sancolor))
ripples(cloud,to0x(sancolor))
ripples(info,to0x(sancolor))
ripples(save,to0x(sancolor))

back.onClick=function()
  autosave()
  activity.finish()
end

review.onClick=function()
  if isStared==true then
    loadcode()
   else
    reviewmds()
  end
end

save.onClick=function()
  saveNote()
end


cloud.onClick=function()
  local function dtro(key,text,atphone,token,isall)
    isall=tostring(isall)
    --token=""
    --过滤处理
    local text=text:gsub("\n","\n"):gsub('"',"'")

    if token and text and key then
      urld="https://oapi.dingtalk.com/robot/send?access_token="..token
      data=([==[{
    "msgtype": "text", 
    "text": {
        "content": "]==]..key..text..[==["
    }, 
    "at": {
        "atMobiles": [
            "]==]..atphone..[==["
        ], 
        "isAtAll": ]==]..isall..[==[
    }
  
}]==])
      --   print(data)--记得这行
      -- data=dump(data)
      data=tostring(data)
      require "import"
      import"http"
      header={
        ["User-Agent"]= "Mozilla/5.0 (Windows NT 7.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904/developer/luoying/xiaow3493@Gmail",
        ["Content-Type"]="application/json"
      }
      Http.post(urld,data,cookie,"utf8",header,function(code,content)
        if code==200 then
          if (content:find("ok")) then
            soToast("推送成功\n "..content)
            return true
           else
            print("错误#\n返回"..content)
            return false
          end
         else
          print('请求服务端失败'..code.."\n")
          return false
        end
      end)
    end

  end


  local function 圆角(控件,背景色,角度)
    import "android.graphics.drawable.GradientDrawable"
    local gd=GradientDrawable()
    .setShape(GradientDrawable.RECTANGLE)
    .setColor(背景色)
    .setCornerRadii(角度)
    if 控件 then
      控件.setBackgroundDrawable(gd)
    end
    return gd
  end
  local upinfo=function(title,messages)

    mBuilder = Notification.Builder(this);
    mBuilder.setSmallIcon(R.drawable.icon)--设置图标
    mBuilder.setContentTitle(title);--大标
    mBuilder.setContentText(messages);--小标
    mBuilder.setAutoCancel(true);--设置这个标志当用户单击面板就可以让通知将自动取消
    --mBuilder.setDefaults( Notification.DEFAULT_SOUND | Notification.DEFAULT_VIBRATE) --使用默认震动
    mBuilder.setDefaults( Notification.DEFAULT_SOUND )
    notificationManager =activity.getSystemService(Context.NOTIFICATION_SERVICE)
    notificationIntent = Intent("android.intent.action.VIEW");
    notificationIntent.setClassName(this.getPackageName(),"com.androlua.Welcome")
    pendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, notificationIntent, Intent.FLAG_ACTIVITY_NEW_TASK);
    mBuilder.setContentIntent(pendingIntent).setAutoCancel(false)
    notificationManager.notify(1, mBuilder.build()) --发送通知
    --notificationManager.cancel(1);           --关闭通知
  end

  local infos=AlertDialog.Builder(this)
  infos.setTitle("推送至通知栏")
  infos.setMessage("推送此条至通知栏用于提示\n需要开启通知权限\n")
  infos.setPositiveButton("推送",{onClick=function(v)
      if pcall(function()
          upinfo(titles,note_content.text)
        end)
        then
        soToast("成功!")
       else
        soToast("错误...")
      end
  end})
  infos.setNeutralButton("开启通知权限",{onClick=function(v)
      import "android.content.Intent"
      import "android.provider.Settings"
      activity.startActivity(Intent(Settings.ACTION_SETTINGS))
  end})
  infos.setNegativeButton("取消",nil)



  items={}
  table.insert(items,"通知栏推送")
  table.insert(items,"钉钉推送")
  table.insert(items,"生成图片")
  table.insert(items,"取消操作")
  --列表对话框
  selects=AlertDialog.Builder(this)
  selects.setTitle("选择渠道")
  selects.setItems(items,{onClick=function(l,v)
      if (items[v+1])=="生成图片" then
        local opp=note_content.Text
        activity.newActivity("action/txttopic",{opp,path})

      end
      if (items[v+1])=="通知栏推送" then
        local info=infos.show()
        圆角(info.getWindow(),0xfffafafa,{25,25,25,25,25,25,25,25})
      end
      if (items[v+1])=="钉钉推送" then

        --输入对话框
        local input={
          LinearLayout;
          orientation="vertical";
          Focusable=true,
          FocusableInTouchMode=true,
          {
            TextView;
            id="tokend",
            textSize="15sp",
            layout_marginTop="10dp";
            layout_marginLeft="3dp",
            layout_width="80%w";
            layout_gravity="center",
            text="Token";
          };
          {
            EditText;
            hint="输入token";
            layout_marginTop="5dp";
            layout_width="80%w";
            layout_gravity="center",
            id="tokens";
            --InputType="textPassword";--设置密码输入
            password="true";--显示类型为密码
          };
          {
            TextView;
            id="atphoned",
            textSize="15sp",
            layout_marginTop="10dp";
            layout_marginLeft="3dp",
            layout_width="80%w";
            layout_gravity="center",
            text="Atphone";
          };
          {
            EditText;
            hint="输入艾特人的手机号码";
            layout_marginTop="5dp";
            layout_width="80%w";
            layout_gravity="center",
            id="atphones";
            --InputType="textPassword";--设置密码输入
            password="true";--显示类型为密码
          };
          {
            TextView;
            id="keyd",
            textSize="15sp",
            layout_marginTop="10dp";
            layout_marginLeft="3dp",
            layout_width="80%w";
            layout_gravity="center",
            text="Key";
          };
          {
            EditText;
            hint="输入关键口令";
            layout_marginTop="5dp";
            layout_width="80%w";
            layout_gravity="center",
            id="keys";
            --  InputType="textPassword";--设置密码输入
            --  password="true";--显示类型为密码
          };
        };

        ding=AlertDialog.Builder(this)
        ding.setTitle("设置参数")
        ding.setView(loadlayout(input))
        ding.setPositiveButton("确定推送",{onClick=function(v)
            key=(keys.Text)
            atphone=(atphones.Text)
            token=(tokens.Text)
            ensave("token",token,function()end)
            ensave("atphone",atphone,function()end)
            ensave("key",key,function()end)
            dtro(key,titles..note_content.Text,atphone,token,false)
        end})
        ding.setNegativeButton("取消",nil)
        local dings=ding.show()
        圆角(dings.getWindow(),0xfffafafa,{25,25,25,25,25,25,25,25})

        import "android.view.View$OnFocusChangeListener"
        function foc()
          keys.setOnFocusChangeListener(OnFocusChangeListener{
            onFocusChange=function(v,hasFocus)
              if hasFocus then
                keyd.setTextColor(to0x(subcolor))
               else
                keyd.setTextColor(0xff646A58)
              end
          end})
          atphones.setOnFocusChangeListener(OnFocusChangeListener{
            onFocusChange=function(v,hasFocus)
              if hasFocus then
                atphoned.setTextColor(to0x(subcolor))
               else
                atphoned.setTextColor(0xff646A58)
              end
          end})
          tokens.setOnFocusChangeListener(OnFocusChangeListener{
            onFocusChange=function(v,hasFocus)
              if hasFocus then
                tokend.setTextColor(to0x(subcolor))
               else
                tokend.setTextColor(0xff646A58)
              end
          end})
        end
        function check()
          token=(deread("token",nil))
          --  print(token)
          key=(deread("key",nil))
          atphone=(deread("atphone",nil))
          if key and token and atphone then
            tokens.setText(token)
            keys.setText(key)
            atphones.setText(atphone)
          end
        end
        check()
        FakeBold(tokend)
        FakeBold(keyd)
        FakeBold(atphoned)
        foc()

      end
  end})
  selects.show()


end


info.onClick=function()
  local function getFileSize(path)
    import "java.io.File"
    import "android.text.format.Formatter"
    size=File(tostring(path)).length()
    Sizes=Formatter.formatFileSize(activity, size)
    return Sizes
  end

  local function 圆角(控件,背景色,角度)
    import "android.graphics.drawable.GradientDrawable"
    local gd=GradientDrawable()
    .setShape(GradientDrawable.RECTANGLE)
    .setColor(背景色)
    .setCornerRadii(角度)
    if 控件 then
      控件.setBackgroundDrawable(gd)
    end
    return gd
  end

  local infos=AlertDialog.Builder(this)
  infos.setTitle("记事信息")
  infos.setMessage("创建时间: "..StrToTable(io.open(path):read("*a"))["date"]["create"] .."\n更新时间: "..StrToTable(io.open(path):read("*a"))["date"]["update"] .."\n\n字数统计: (含标点符号)\n内容字数: "..utf8.len(note_content.text) .."\n标题字数: "..utf8.len(note_title.text).."\n总字数: "..utf8.len(note_title.text)+utf8.len(note_content.text).."\n\n文件大小: "..getFileSize(path))
  infos.setPositiveButton("好的",nil)
  local info=infos.show()
  圆角(info.getWindow(),0xfffafafa,{25,25,25,25,25,25,25,25})
end


function saveNote()
  if isStared==true then
    note_content.format()
  end
  local tosave_c=string.gsub(note_content.text,"%[",":xjszkh:")
  local tosave_c=string.gsub(tosave_c,"%]",":xjsykh:")
  local f,e=pcall(function ()
    io.open(path,"w+"):write([[{
["date"]	={
["create"]	="]]..create_time..[[";
["update"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
};
["content"]	={
["color"]=]]..card_color..[[;
["star"]=]]..tostring(isStared)..[[,
["category"]="]]..note_category..[[";
["title"]	="]]..note_title.text..[[";
["messages"]	=]].."[["..tosave_c.."]]"..[[;
};
}]]):close()
  end)
  if not e then
    soToast("已保存")
  end
end

function autosave()
  if getData("switch","是否保存")=="true" then
    saveNote()
  end
end


one=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    saveNote()
    soToast("已保存")
    activity.finish()
    --[[ if one+2 > tonumber(os.time()) then
      autosave()
      activity.finish()
     
     else
      layout={
        LinearLayout,
        layout_width="100%w";
        gravity="center";
        layout_height="fill";
        background="#B05D86FF";
        {
          TextView;
          gravity="center";
          text="请注意保存";
          textColor="#FFFDFDFD";
          textSize=="15sp";
          layout_width="110%w";
          layout_height="35dp";
        };
      }
      lay=loadlayout(layout)
      
      if getData("switch","是否保存")=="true" then
       else
        local toast=Toast.makeText(activity,"提示",Toast.LENGTH_LONG).setView(lay).show().setGravity(Gravity.BOTTOM, 0, 0).show()

      end
      one=tonumber(os.time())
     
    end
   --]]
    return true
  end
end--结束

function onPause()
  autosave()
end





--弹窗布局
local putout={
  LinearLayout;
  layout_height="50%h";
  orientation="horizontal";
  {
    LinearLayout;
    background="#ffffffff";
    layout_width="fill";
    layout_height=(activity.getHeight()*0.5);
    id="dia";
    orientation="vertical";
    {
      LinearLayout;
      layout_margin="6dp";
      layout_width="fill";
      layout_height="wrap";
      {
        TextView;
        text="预览窗口";
        --layout_height="fill";
        textSize="18";
        singleLine="true";
        gravity="center";
        id="retitle";
        layout_marginLeft="10dp";
      };
      {
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        gravity="end";
      };
    };
    {
      LinearLayout;
      layout_margin="0dp";
      layout_width="fill";
      layout_height="fill";
      {
        LuaWebView;
        id="reviewmd";
        layout_height="fill";
        layout_width="fill";
      };
    };
  };
};



--创建Dialog弹窗
redialog=BottomDialog(activity)--R.style.BottomDialog)
--设置弹窗布局
redialog.setView(loadlayout(putout))
--设置弹窗位置
redialog.setGravity(Gravity.BOTTOM)
--设置弹窗高度,宽度，最低高度
redialog.setHeight(activity.getHeight()*0.6)
redialog.setMinHeight(activity.getHeight()*0.3)
redialog.setWidth(activity.getWidth())
--设置圆角
redialog.setRadius(20,0xffffffff)

function reviewmds(textto)
  redialog.show()
  retitle.setTextColor(to0x(subcolor))
  redialog.setCanceledOnTouchOutside(true);--设置触摸弹窗外部隐藏弹窗
  reviewmd.loadDataWithBaseURL("",md(tostring(note_content.text)),"text/html","utf-8",nil)
end

function loadcode()
  local function wrt(path,content)
    import "java.io.File"
    local f=File(tostring(File(tostring(path)).getParentFile())).mkdirs()
    io.open(tostring(path),"w"):write(tostring(content)):close()
  end
  if (note_content.text):find[[function loadstring]] then;else
    if (note_content.text):find[[function xpcall]] then;else
      wrt(activity.getLuaDir().."/action/testcode.lua",note_content.text)
      activity.newActivity("action/testcode",{参数})
      soToast("已执行")
    end
  end
end


function click(v)
  note_content.append(v.Text)
end
function newButton(text)
  dingyi=
  {
    RippleLayout,--水波纹布局
    RippleColor=subcolor;--水波纹颜色
    --RippleLineColor='';--水波纹线条颜色
    circle=true;--长按圆圈
    {
      TextView;
      textSize="15sp";
      text=text,
      layout_width="9%w";--卡片宽度
      layout_height="32dp";
      textColor="#FF313131";
      gravity='center';
      --      style="?android:attr/buttonBarButtonStyle";
      onClick=click
    }
  }
  sc.addView(loadlayout(dingyi))
end

--github@sudoskys



for c in io.lines(root_path.."fuhao.dat") do
  --print(c)
  newButton(c)
end
--防止输入法影响布局

activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)


