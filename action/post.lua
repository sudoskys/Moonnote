--github@sudoskys
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.PorterDuff"
import "android.content.Context"
import "android.os.Build"
import "java.net.NetworkInterface"
import "com.androlua.Http"
import "http"


--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xFF1F96F2)
activity.ActionBar.hide()--隐藏标题栏

catkey=(activity.getGlobalData().key)
if catkey==2021/03/27 then--建议在文件中替换自己的比对key

 else
  print("Running error")
  activity.finish()--关闭当前页面
end

a="2"
b="0"
c="1"
d="4"

function be64解码(内容)
  local Base64=luajava.bindClass("android.util.Base64")
  return String(Base64.decode(内容,Base64.DEFAULT)).toString()
end

--写入数据函数
function putData(name,key,value)
  this.getApplicationContext().getSharedPreferences(name,0).edit().putString(key,value).apply()--3255-2732
  return true
end

function getData(name,key)--验证
  local data=this.getApplicationContext().getSharedPreferences(name,0).getString(key,nil)--325-5273-2
  return data
end


--顶部图片.setImageBitmap(loadbitmap("/drawable/undraw_Post_re.png"))
function 波纹(id,颜色)--用了Pretend大佬的波纹代码
  import "android.content.res.ColorStateList"
  local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  ripple=typedArray.getResourceId(0,0)
  Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色})))
end
function 设置编辑框颜色(eid,color)
  eid.getBackground().setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP))
end

function 是否联网()
  return activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo()
end


pass=a..b..a..d..c..a




function isVpnUsed()
  require "import"
  import "java.net.NetworkInterface"
  import "java.util.Collections"
  import "java.util.Enumeration"
  import "java.util.Iterator"
  local niList = NetworkInterface.getNetworkInterfaces()
  if niList ~= nil then
    local it = Collections.list(niList).iterator()
    while it.hasNext() do
      local intf = it.next()
      if intf.isUp() and intf.getInterfaceAddresses().size() ~= 0 then
        if String("tun0").equals(intf.getName()) or String("ppp0").equals(intf.getName()) then
          return true
        end
      end
    end
    return false
  end
end

--使用方法
--[[
if isVpnUsed() then
  print('以开启')
 else
  print('未开启')
end
]]

--[[
function 光标颜色(控件,颜色)
  import "android.graphics.*"
  local mEditorField=TextView.getDeclaredField('mEditor')
  mEditorField.setAccessible(true)
  local mEditor = mEditorField.get(控件)
  local field = Editor.getDeclaredField('mCursorDrawable')
  field.setAccessible(true)
  local mCursorDrawable=field.get(mEditor)
  local mccdf = TextView.getDeclaredField('mCursorDrawableRes')
  mccdf.setAccessible(true)
  local mccd = activity.getResources().getDrawable(mccdf.getInt(控件))
  mccd.setColorFilter(PorterDuffColorFilter(颜色,PorterDuff.Mode.SRC_ATOP))
  mCursorDrawable[0] = mccd
  mCursorDrawable[1] = mccd
end
]]

function 获取状态栏高度()
  import "android.os.Build"
  if Build.VERSION.SDK_INT >= 19 then
    resourceId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android")
    return activity.getResources().getDimensionPixelSize(resourceId)
   else
    return 0
  end
end


function 中部提示(sth)
  sth=tostring(sth)
  body={
    CardView;
    CardBackgroundColor="#C0000000";
    elevation="0dp";
    -- layout_width="95%w";
    layout_height="42dp";
    radius="18dp";
    id="Toastbody";
    {
      TextView;
      textSize="15sp";
      TextColor="#FFffffff";
      layout_width="45%w";
      layout_height="42dp";
      gravity="center";
      text="出错";
      id="Toastmessage";
    };
  }
  local Toastbody=Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(body))
  Toastbody.setGravity(Gravity.CENTER,0,60)
  Toastmessage.Text=tostring(sth)
  Toastbody.show()
  return Toastbody
end







import"action/lock"
function dtro(key,text,atphone,token,isall)
  isall=tostring(isall)
  --token=""
  urld="https://oapi.dingtalk.com/robot/send?access_token="..token
  data=([===[{
    "msgtype": "text", 
    "text": {
        "content": "]===]..key..text..[===["
    }, 
    "at": {
        "atMobiles": [
            "]===]..atphone..[===["
        ], 
        "isAtAll": ]===]..isall..[===[
    }
}]===])
  -- print(data)
  -- data=dump(data)
  data=tostring(data)
  require "import"
  import"http"
  header={
    ["User-Agent"]= "Mozilla/5.0 (Windows NT 7.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904/developer",
    ["Content-Type"]="application/json"
  }
  Http.post(urld,data,cookie,"utf8",header,function(code,content)
    if code==200 then
      if (content:find("ok")) then
        -- print("OK#\n返回"..content)
        中部提示("发送成功 ✧٩(ˊωˋ*)و✧")
        -- return content
       else
        -- print("错误#\n返回"..content)
        中部提示("发送失败 Σ( ° △ °|||)︴")
        putData("repost",os.date("%d"),"No")
        return content
      end
     else
      中部提示('请求服务端失败'..code.."\n")
    end
  end)
end


import "android.provider.Settings$Secure"



包名=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
版本=tostring(包名.versionName)
版本号=tonumber(包名.versionCode)
device_model = Build.MODEL --设备型号
version_sdk = Build.VERSION.SDK --设备SDK版本
version_release = Build.VERSION.RELEASE --设备的系统版本
android_id = Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)
packinfo=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
version=tostring(packinfo.versionName)
versioncode=tostring(packinfo.versionCode)



--high=获取状态栏高度()

local lay=
{
  LinearLayout;
  layout_height="fill";
  orientation="vertical";
  layout_width="fill";
  {
    LinearLayout;
    -- layout_height="18dp";
    layout_height="0";
    layout_width="fill";
    background="#2196F3";
    elevation="2dp";
    id="status_bar";
  };
  {
    LinearLayout;
    layout_height="54dp";
    orientation="horizontal";
    layout_width="fill";
    background="#2196F3";
    elevation="2dp";
    {
      LinearLayout;
      layout_height="55dp";
      layout_width="55dp";
      gravity="center";
      id="Sideslip";
      {
        ImageView;
        layout_height="28dp";
        src="drawable/back.png";
        colorFilter="#ffffffff";
        layout_width="25dp";
      };
    };

    {
      LinearLayout;
      layout_height="fill";
      layout_weight="1";
      orientation="horizontal";
      {
        TextView;
        text="反馈";
        id="title";
        textColor="#ffffffff";
        textSize="22sp";
        layout_gravity="center";
      };
    };
  };
  {
    LinearLayout;
    LinearLayout;
    layout_width="fill";
    layout_height="fill";
    orientation="vertical";
    id="主框架";


    {
      LinearLayout;
      layout_width="fill";
      layout_height="fill";
      orientation="vertical";
      {
        ScrollView;
        background="#EDFFFFFF";
        layout_width="fill";
        layout_height="fill";
        verticalScrollBarEnabled=false,--隐藏纵向滑条

        {
          LinearLayout;
          gravity="center";
          orientation="vertical";
          layout_height="22%h";
          layout_width="fill";



          {
            LinearLayout;
            gravity="center";
            layout_width="fill";
            layout_height="36%w";
            layout_marginTop="20dp";
            orientation="vertical";
            {
              TextView;
              textColor="#FF000000";
              layout_width="match_parent";
              textSize="18";
              text="问题详情";
              id="title01";
              backgroundColor="#FFFFFFFF";
              layout_marginBottom="-1%w";
              layout_marginLeft="3%w";
              layout_left="1";
              gravity="left|center";
            };
            {
              CardView;
              id="意见编辑框";
              elevation="0dp";
              layout_height="26%w";
              layout_width="fill";
              layout_margin="3.5%w";
              radius="10dp";
              CardBackgroundColor="#E5E1E1E1";
              {
                EditText;
                textColor="#000000";
                layout_height="fill";
                layout_width="fill";
                textSize="15sp";
                hint="说说你的问题";
                background="#E5E1E1E1";
                id="意见";
                hintTextColor="#FF9b9b9b";
                singleLine=false;
              };
            };
          };
          {
            LinearLayout;
            gravity="center";
            layout_width="fill";
            layout_height="30%w";
            orientation="vertical";
            {
              TextView;
              textColor="#FF000000";
              layout_width="match_parent";
              id="title02";
              textSize="18";
              text="联系方式";
              backgroundColor="#FFFFFFFF";
              layout_marginBottom="-1%w";
              layout_marginLeft="3%w";
              layout_left="1";
              gravity="left|center";
            };
            {
              CardView;
              id="用户编辑框";
              elevation="0dp";
              layout_height="12%w";
              layout_width="fill";
              layout_margin="3.5%w";
              radius="10dp";
              CardBackgroundColor="#E5E1E1E1";
              {
                EditText;
                textColor="#000000";
                layout_height="fill";
                layout_width="fill";
                textSize="15sp";
                hint="填写你的邮箱地址便于我们回信(填写QQ号默认QQ邮箱)";
                background="#E5E1E1E1";
                id="用户";
                hintTextColor="#FF9b9b9b";
                singleLine="true";
              };
            };
          };
          {
            CardView;
            id="post";
            layout_height="10%w";
            layout_margin="18dp";
            CardElevation="0px";
            layout_width="80%w";
            radius="6dp";
            CardBackgroundColor="#2196F3";
            {
              TextView;
              id="like_text";
              layout_height="fill";
              text="提交";
              textColor="#ffffffff";
              layout_width="fill";
              textSize="16";
              gravity="center";
            };
          };

          {
            LinearLayout;
            gravity="center";
            layout_width="fill";
            layout_height="66%w";
            id="顶部布局";
            {
              CardView;
              id="顶部卡片";
              elevation="0dp";
              layout_height="40%w";
              layout_width="78%w";
              radius="14dp";
              CardBackgroundColor="#FFFFFFFF";
              {
                ImageView;
                id="顶部图片";
                layout_width="match_parent";
                scaleType="centerInside";
                layout_height="match_parent";
                src="drawable/code.png";
                layout_margin="5dp";
              };
            };
          };

        };

      };
    };

  };
};

activity.setContentView(loadlayout(lay))

波纹(Sideslip,0x40000000)
波纹(like_text,0x40000000)
--调用方法
--光标颜色(意见,0xFF00A7D7)
--光标颜色(用户,0xFF00A7D7)

Sideslip.onClick=function()
  activity.finish()
end


ispost=false
--序列号
local id =import "android.os.Build"
local dd=id.SERIAL
--android_id
local set=import "android.provider.Settings"
local id = set.System.getString(this.getContentResolver(), "android_id")
--拼接codeid
local codeid =dd.."#"..id

if 是否联网() then else
  中部提示("网络连接失败..Σ( ° △ °|||)︴")
end
like_text.onClick=function()
  if isVpnUsed() then
    中部提示("网络连接失败..Σ( ° △ °|||)︴")
   else
    if getData("repost",os.date("%d"))~="OK" then
      sender=用户.text
      messagea=意见.text
      atphone="no"
      key="#问题反馈##月笔记#"
      --     token="d72202b617d6fb0be50bac91642f748bfeca1e9e6d64d8f94c1d57611c233006"
      附属信息=("设备型号："..device_model.."\n设备SDK："..version_sdk.."\n安卓版本："..version_release.."\n设备标志："..android_id.."\n当前app版本名："..version.."\n当前app版本号："..versioncode)
      messages="发送人"..sender.."\n\n\n"..messagea.."\n\n\n"..附属信息
      if sender=="" or messagea=="" then
        中部提示("您还没写东西呢 ( ‘-ωก̀ )")
       else
        if 限制字数(messages,900) then
          task(500,function()
            dtro(key,messages,atphone,token,false)
            --sendEmail(sendto,messages)
            --            中部提示("发送成功 ✧٩(ˊωˋ*)و✧")
            putData("repost",os.date("%d"),"OK")
          end)
          ispost=true
         else
          中部提示("至多800字 •́ω•̀)")
        end
      end
     else
      中部提示("今天已经提交过了 ( ﾟωﾟ)")
    end
  end
end

function 限制字数(字符串,字数)
  if #字符串>字数 then
    return false
   else
    return true
  end
end



--post.BackgroundDrawable=边框(4,0xFFFFFFFF,0xFF007EF8,16);

function FakeBoldText(ID)
  if pcall(function()
      import "android.graphics.Paint"
      ID.getPaint().setFakeBoldText(true)
    end) then
   else
    print"字体粗化设置出错"
  end
end
FakeBoldText(title)
FakeBoldText(title01)
FakeBoldText(title02)






