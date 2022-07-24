
import "java.io.File"

Dataword="_monote"..this.packageName
import"android.util.Base64"
import"javax.crypto.spec.SecretKeySpec"
import"javax.crypto.Cipher"
import"javax.crypto.spec.PBEKeySpec"
import"javax.crypto.SecretKeyFactory"
function encrypt(content,password)
  --数据加密 (By: 32552732)
  local jdpuk=Cipher.getInstance("AES")
  jdpuk.init(Cipher.ENCRYPT_MODE,SecretKeySpec(SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1")
  .generateSecret(PBEKeySpec(String(password).toCharArray(),byte[1],1,128)
  ).getEncoded()
  ,"AES"))
  return Base64.encodeToString(jdpuk.doFinal(String(content).getBytes("UTF-8"))
  ,Base64.NO_WRAP)
  ,"By: 32552732"
end
function decrypt(content,password)
  --数据解密 (By: 32552732)
  local jdpuk=Cipher.getInstance("AES")
  jdpuk.init(Cipher.DECRYPT_MODE,SecretKeySpec(SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1")
  .generateSecret(PBEKeySpec(String(password).toCharArray(),byte[1],1,128)
  ).getEncoded()
  ,"AES"))
  return String(jdpuk.doFinal(Base64.decode(content,Base64.NO_WRAP))
  ),"By: 32552732"
end


function 检查目录()
  if pcall(function()------------------------
      import "java.io.*"
      fl=luajava.astable(noteDirFile.listFiles())
      local POS={}
      if (dump(fl))==(dump(POS)) then
        --soToast("没有笔记")
        没有笔记.setVisibility(View.VISIBLE)
        Pro1.setVisibility(View.GONE)
        点击刷新.onClick=function()
          Refresh()
        end
       else
        没有笔记.setVisibility(View.GONE)
      end
    end) then
   else
    print("刷新错误  :(")
  end
end



function Refresh()
  Openroad()
  检查目录()
  notenumber.text="共计 "..getDirNumber(notePath,"note").." 篇笔记"

  --sr.setRefreshing(true)
  -- if getData("switch","是否显示")=="true" then
  --  else
  --end
  activity.newTask(function(noteDirFile,notePath)
    require "import"
    import "java.io.*"

    import"values.base"
    import"mods.runbase"
    local function lasttime(path)
      f = File(path);
      cal = Calendar.getInstance();
      time = f.lastModified()
      cal.setTimeInMillis(time);
      return cal.getTime().toLocaleString()
    end
    fl=luajava.astable(noteDirFile.listFiles())
    table.sort(fl,function(a,b)
      --print(lasttime(tostring(a)))
      return (lasttime(tostring(b)))<(lasttime(tostring(a)))

      -- return string.upper(a.Name)<string.upper(b.Name)
    end)
    ------------------
    datas={}
    function getDirNumber(file,dirname)
      import "java.io.*"
      --      if File(tostring(file).."/"..dirname).isDirectory() then
      local file=File(tostring(file).."/"..dirname)
      local list=file.listFiles()
      local tableList=luajava.astable(list)
      local number=table.size(tableList)
      luajava.clear(file)
      luajava.clear(list)
      local tableList=nil
      return number
      --     else
      --       File(tostring(file).."/"..dirname).mkdirs()
      -- print("不存在")
      --   end
    end
    function Filesuffix(name)
      return name:match(".+%.(%w+)$")
    end
    function 边框圆角(边宽度,边框色,背景色,圆角度)
      import "android.graphics.drawable.GradientDrawable"
      drawable = GradientDrawable()
      drawable.setShape(GradientDrawable.RECTANGLE)
      drawable.setStroke(边宽度,tonumber(边框色))
      drawable.setColor(tonumber(背景色))
      drawable.setCornerRadius(圆角度)
      return drawable
    end
    function StrToTable(str)
      if str == nil or type(str) ~= "string" then
        return
      end
      return loadstring("return " .. str)()
    end

    function getActuallyTitle(ori)
      if #ori<1 then
        return "无标题"
       else
        return ori
      end
      print (ori)
    end


    function getActuallyContent(ori)
      if #ori<1 then
        return "无内容"
       else
        return ori
      end
      print (ori)
    end


    for index,content in ipairs(fl) do
      if pcall(function()------
          if content.isDirectory() then
           else
            if activity.getGlobalData()["iscount"]=="true" then
              table.insert(datas,{
                date=getActuallyTitle(StrToTable(io.open(tostring(content)):read("*a"))["content"]["title"]),
                textto=getActuallyContent(string.gsub(string.gsub(StrToTable(io.open(tostring(content)):read("*a"))["content"]["messages"],":xjszkh:","["),":xjsykh:","]")),
                likes=string.upper(Filesuffix(tostring(content))),
                roads=tostring(content),
                卡片={BackgroundDrawable=边框圆角(4,to0x(maincolor),to0x(backcolor),20)},
              })
             else
              --print"载入测试"
              table.insert(datas,{
                date=getActuallyTitle(StrToTable(io.open(tostring(content)):read("*a"))["content"]["title"]),
                textto=getActuallyContent(string.gsub(string.gsub(StrToTable(io.open(tostring(content)):read("*a"))["content"]["messages"],":xjszkh:","["),":xjsykh:","]")),
                likes=string.upper(Filesuffix(tostring(content))),
                roads=tostring(content),
                卡片={BackgroundDrawable=边框圆角(4,to0x(maincolor),to0x(backcolor),20)},
              })
              --print(Filesuffix(tostring(content)))
            end

          end
        end) then
       else
        print("文件格式错误 .."..tostring(content))
      end------------------------

    end
    ------------------------

    return datas
  end
  ,function(datas)
    _G.datas=datas
    Pro1.setVisibility(View.GONE)
    if adp then
      luajava.clear(adp)
    end
    selector()
    -- sr.setRefreshing(false)
  end).execute({noteDirFile,notePath})
end



function translateNote(type,note)
  Openroad()
  import "android.content.Context"
  local things=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()

  local function new(things,note,type)
    if things then
      if type=="lua" then
        log="note"..os.time()..".lua"
        isload="true"
       else
        log="note"..os.time()..".md"
        isload="false"
      end
      log=note..tostring(log)
      soToast(log)
      File(log).createNewFile()
      io.open(log,"w+"):write([[{
["date"]	={
["create"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
["update"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
};
["content"]	={
["color"]="0xffffffff",
["category"]="导入",
["title"]	="导入";
["star"]=]]..isload..[[,
["messages"]	=]].."[["..things.."]]"..[[;
};
}]]):close()
      this.newActivity("mods/edit",{log})
      Refresh()
     else
      soToast("No content")
    end
  end

  AlertDialog.Builder(this)
  .setTitle("导入以下内容")
  .setMessage(things)
  .setPositiveButton("确认",{onClick=function(v) new(things,note,type)end})
  .setNeutralButton("取消",nil)
  --.setNegativeButton("否认",nil)
  .show()


end

function newNote(type,note)
  Openroad()
  if type=="lua" then
    log="note"..os.time()..".lua"
    isload="true"
   else
    log="note"..os.time()..".md"
    isload="false"
  end
  log=note..tostring(log)
  soToast(log)
  File(log).createNewFile()
  io.open(log,"w+"):write([[{
["date"]	={
["create"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
["update"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
};
["content"]	={
["color"]="0xffffffff",
["category"]="分类标签",
["title"]	="写写什么";
["star"]=]]..isload..[[,
["messages"]	=]].."[[]]"..[[;
};
}]]):close()
  this.newActivity("mods/edit",{log})
  Refresh()
end




function searchtxt(filter)
  activity.newTask(function(noteDirFile,notePath,filter)
    require "import"
    import "java.io.*"
    import"values.base"
    import"mods.runbase"
    filter=tostring(filter)
    local function lasttime(path)
      f = File(path);
      cal = Calendar.getInstance();
      time = f.lastModified()
      cal.setTimeInMillis(time);
      return cal.getTime().toLocaleString()
    end


    fl=luajava.astable(noteDirFile.listFiles())
    table.sort(fl,function(a,b)

      return (lasttime(tostring(b)))<(lasttime(tostring(a)))
      --return string.upper(a.Name)<string.upper(b.Name)
    end)
    datas={}
    function getDirNumber(file,dirname)
      import "java.io.*"
      --      if File(tostring(file).."/"..dirname).isDirectory() then
      local file=File(tostring(file).."/"..dirname)
      local list=file.listFiles()
      local tableList=luajava.astable(list)
      local number=table.size(tableList)
      luajava.clear(file)
      luajava.clear(list)
      local tableList=nil
      return number
      --     else
      --       File(tostring(file).."/"..dirname).mkdirs()
      -- print("不存在")
      --   end
    end
    function Filesuffix(name)
      return name:match(".+%.(%w+)$")
    end
    function 边框圆角(边宽度,边框色,背景色,圆角度)
      import "android.graphics.drawable.GradientDrawable"
      drawable = GradientDrawable()
      drawable.setShape(GradientDrawable.RECTANGLE)
      drawable.setStroke(边宽度,tonumber(边框色))
      drawable.setColor(tonumber(背景色))
      drawable.setCornerRadius(圆角度)
      return drawable
    end
    function StrToTable(str)
      if str == nil or type(str) ~= "string" then
        return
      end
      return loadstring("return " .. str)()
    end

    function getActuallyTitle(ori)
      if #ori<1 then
        return "无标题"
       else
        return ori
      end
      print (ori)
    end


    function getActuallyContent(ori)
      if #ori<1 then
        return "无内容"
       else
        return ori
      end
      print (ori)
    end

    filter_resultcount=0
    for index,content in ipairs(fl) do
      if pcall(function()------------------------

          if content.isDirectory() then
           else
            if StrToTable(io.open(tostring(content)):read("*a"))["content"]["category"]:find(filter) or StrToTable(io.open(tostring(content)):read("*a"))["content"]["title"]:find(filter) or StrToTable(io.open(tostring(content)):read("*a"))["content"]["messages"]:find(filter) then
              filter_resultcount=filter_resultcount+1
              table.insert(datas,{
                date=getActuallyTitle(StrToTable(io.open(tostring(content)):read("*a"))["content"]["title"]),
                textto=getActuallyContent(string.gsub(string.gsub(StrToTable(io.open(tostring(content)):read("*a"))["content"]["messages"],":xjszkh:","["),":xjsykh:","]")),
                likes=string.upper(Filesuffix(tostring(content))),
                roads=tostring(content),
                卡片={BackgroundDrawable=边框圆角(4,to0x(maincolor),to0x(backcolor),20)},
              })
            end
          end
        end) then
       else
        print("错误文件"..tostring(content))
      end------------------------
    end
    ------------------------

    return datas,filter_resultcount
  end
  ,function(datas,filter_resultcount)
    _G.datas=datas
    Pro1.setVisibility(View.GONE)
    if adp then
      luajava.clear(adp)
    end
    selector()
    --  adp=LuaAdapter(activity,datas,item)
    --   notelist.Adapter=adp
    --   sr.setRefreshing(false)
    notenumber.text="索引到 "..filter_resultcount.." 篇文档"

  end).execute({noteDirFile,notePath,filter})
end









function 提示(text,color)
  text=tostring(text)
  if color==nil then
    color="#CC4E93D8"
  end
  color=tostring(color)
  Toastbody={
    LinearLayout,
    layout_width="100%w";
    gravity="center";
    layout_height="fill";
    background=color;
    {
      TextView;
      gravity="center";
      text="空!";
      id="Toast_TextView";
      textColor="#FFFDFDFD";
      textSize=="15sp";
      layout_width="110%w";
      layout_height="36dp";
    };
  }
  local Toastbody=Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(Toastbody))
  --LENGTH_SHORT     2s
  --LENGTH_LONG      3.5s
  --Gravity.BOTTOM   底部
  --Gravity.CENTER   中部
  --Gravity.TOP      顶部
  Toastbody.setGravity(Gravity.BOTTOM,0,0)
  Toast_TextView.Text=tostring(text)
  Toastbody.show()
end
function 检测更新(URL,PURL,headerua)
  activity.getGlobalData()['key']=2021/03/27--默认key，建议自己改改
  import 'android.text.SpannableString'
  import 'android.text.style.ForegroundColorSpan'
  import 'android.text.Spannable'
  header={
    ['User-Agent'] = headerua
  }
  if header==nil then
    header = {
      ['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
    }
  end
  function 处理网页源码(content)
    content=tostring(content)
    --处理获取的内容
    content = content:gsub('<br>', '') or content
    content = content:gsub('<div>', '') or content
    content = content:gsub('</div>', '') or content
    content = content:gsub('amp;', '') or content
    content = content:gsub('&nbsp;', '') or content
    content = content:gsub('<br>', '\n') or content
    --   content=content:gsub("<","") or content;
    --    content=content:gsub("/","") or content;
    --    content=content:gsub(">","") or content;
    content = content:gsub('<p>', '\n') or content
    content = content:gsub('</p>', '\n') or content
    return content
  end
  function 处理更新信息(content)
    packinfo =
    this.getPackageManager().getPackageInfo(
    this.getPackageName(),
    ((32552732 / 2 / 2 - 8183) / 10000 - 6 - 231) / 9
    )
    当前版本 = tostring(packinfo.versionName) --版本信息
    --当前版本=tonumber(activity.getPackageManager().getPackageInfo(包名, 0).versionName)
    更新版本=tostring(content:match("【upto】(.-)【upto】"))
    更新说明=tostring(content:match("【intro】(.-)【intro】"))
    更新链接=tostring(content:match("【link】(.-)【link】"))
    强制状态=tostring(content:match("【force】(.-)【force】"))
    return 包名,当前版本,更新版本,更新说明,更新链接,强制状态
  end
  function 展示更新(更新版本,当前版本,更新说明,更新链接,强制状态)
    if 更新版本 > 当前版本 then
      dis=AlertDialog.Builder(this)
      dis.setTitle("有新版本更新  "..更新版本)
      if 更新版本==nil then
        更新版本="错误"
      end
      if 更新说明==nil then
        更新说明="未获取到任何内容，后台异常"
      end
      dis.setMessage(更新说明)
      dis.setPositiveButton("前往更新",{onClick=function(v)
          if pcall(function()
              import "android.content.Intent"
              import "android.net.Uri"
              url=更新链接
              viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
              activity.startActivity(viewIntent)
            end) then
           else
            提示(("执行失败...."),"#B2EE567D")
          end
          if 强制状态=="是" then
            os.exit()
          end
      end})
      dis.setNegativeButton("取消",{onClick=function(v)
          if 强制状态=="是" then
            os.exit()
          end
      end})
      if 强制状态=="是" then
        dis.setCancelable(false)
      end
      dis.show()
    end--结束对话框
  end
  Http.get(URL,nil,"utf8",header,function(code, content)
    if code==200 then
      content=处理网页源码(content)
      --包名=activity.getPackageName()
      处理更新信息(content)
      展示更新(更新版本,当前版本,更新说明,更新链接,强制状态)
     else
      提示(("检测更新失败"..code),"#B2EE567D")
      Http.get(PURL,nil,"utf8",header,function(code, content)
        if code==200 then
          content=处理网页源码(content)
          --包名=activity.getPackageName()
          处理更新信息(content)
          展示更新(更新版本,当前版本,更新说明,更新链接,强制状态)
         else
          提示(("检测备用更新失败"..code),"#B2EE567D")
        end
      end)
      --备用地址
    end
  end)
end


pass=function()
  local function rounds(控件,背景色,角度)
    import "android.app.AlertDialog"
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

  local function setcheckbox(cold)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setColorFilter(PorterDuffColorFilter(cold,PorterDuff.Mode.SRC_ATOP));
    return drawable
  end
  --下载文件对话框
  local speak={
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    background="#ffffff";
    {
      CardView;
      radius="6dp";
      elevation="0dp";
      CardBackgroundColor="#ffffff";
      layout_gravity="center";
      layout_width="fill";
      --layout_marginTop="50dp";
      layout_height="fill";
      --layout_margin="10dp";
      {
        LinearLayout;
        layout_gravity="center";
        orientation="vertical";
        layout_width="fill";
        layout_height="fill";
        {
          TextView;
          layout_gravity="center";
          textSize="14";
          text="欢迎使用月笔记";
          layout_margin="10dp";
        };
        {
          TextView;
          layout_height="20%w";
          text=[==[在进入本软件之前，我们很有必要获取您的许可，请您仔细阅读我们的协议。
          
本应用需要您授予存储权限和其他权限才能正常提供服务.
        ]==];
          textSize="14";
          layout_width="fill";
          layout_margin="10dp";
          textColor=maincolor;
        };
        {
          LinearLayout;
          layout_gravity="center";
          {
            CheckBox;
            id="selectb";
          };
          {
            TextView;
            text="我已经阅读并同意";
          };
          {
            TextView;
            text="《软件使用协议》";
            textColor=maincolor;
            id="proto";
          };
          {
            TextView;
            text="和";
          };
          {
            TextView;
            text="《隐私政策》";
            textColor=maincolor;
            id="privacy";
          };
        };
      };
    };
  };
  link=AlertDialog.Builder(this)
  link.setTitle("授权")
  link.setView(loadlayout(speak))
  link.setPositiveButton("同意",{onClick=function(v)
      if selectb.isChecked()==true then
        putData("luoying","shoulder","true")
       else
        putData("luoying","shoulder","false")
        soToast("请阅读并勾选复选框")
        pass()
      end
  end})
  link.setNegativeButton("取消",{onClick=function(v)
      activity.finish()
  end})
  link.setCancelable(false)

  links=link.show()
  import "android.graphics.Paint"
  proto.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG)
  privacy.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG)
  selectb.setChecked(false)
  rounds(links.getWindow(),0xffffffff,{25,25,25,25,25,25,25,25})
  links.getButton(links.BUTTON_POSITIVE).setTextColor(0xff1DA6DD)
  links.getButton(links.BUTTON_NEGATIVE).setTextColor(0xff1DA6DD)
  links.getButton(links.BUTTON_NEUTRAL).setTextColor(0xff1DA6DD)
--github@sudoskys
  proto.onClick=function()
    selectd=1
    activity.newActivity("mods/agree",{selectd})
  end

  privacy.onClick=function()
    selectd=0
    activity.newActivity("mods/agree",{selectd})
  end

  --  selectb.ButtonDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP));
end

