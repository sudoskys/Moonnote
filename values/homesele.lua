require "import"
import "android.widget.*"
import "android.view.*"
import"values.base"
import"mods.runbase"


if getData("switch","是否瀑布")=="true" then
  import"layout.itempu"
  --导入第三方库
  import "android.support.v7.widget.*"
  import "com.LuaRecyclerAdapter"
  import "com.LuaRecyclerHolder"
  import "com.AdapterCreator"
  --带v4的Glide
  import "com.bumptech.glide.*"
  mainlays.addView(loadlayout(
  {
    RecyclerView,
    layout_height="fill",
    layout_width="fill",
    background=backcolor,
    id="notelist",
  }
  ))
  --定义列表
  datas={}


  --adp=LuaAdapter(activity,datas,item)
  --notelist.Adapter=adp


  function setwaterfall()
    --创建一个适配器对象
    adapter=LuaRecyclerAdapter(AdapterCreator({
      getItemCount=function()
        return #datas
      end,
      getItemViewType=function(position)
        return 0
      end,
      onCreateViewHolder=function(parent,viewType)
        local views={}
        holder=LuaRecyclerHolder(loadlayout(itempu,views))
        holder.view.setTag(views)
        return holder
      end,
      onBindViewHolder=function(holder,position)
        -- print(((datas[position+1]["卡片"])))

        view=holder.view.getTag()
        --url=datas[position+1]

        --[[使用glide加载图片(加载贼流畅)
    Glide.with(this)
    .load(url)
    .dontTransform()
    --.override(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL)
    .into(view.img);
--]]

        --copyright © 1999-2020, CSDN.NET, All Rights Reserved



        --截取中英混合的UTF8字符串，endIndex可缺省
        function SubStringUTF8(str, startIndex, endIndex)
          if startIndex < 0 then
            startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
          end

          if endIndex ~= nil and endIndex < 0 then
            endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
          end

          if endIndex == nil then
            return string.sub(str, SubStringGetTrueIndex(str, startIndex));
           else
            return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
          end
        end

        --获取中英混合UTF8字符串的真实字符数量
        function SubStringGetTotalIndex(str)
          local curIndex = 0;
          local i = 1;
          local lastCount = 1;
          repeat
            lastCount = SubStringGetByteCount(str, i)
            i = i + lastCount;
            curIndex = curIndex + 1;
          until(lastCount == 0);
          return curIndex - 1;
        end

        function SubStringGetTrueIndex(str, index)
          local curIndex = 0;
          local i = 1;
          local lastCount = 1;
          repeat
            lastCount = SubStringGetByteCount(str, i)
            i = i + lastCount;
            curIndex = curIndex + 1;
          until(curIndex >= index);
          return i - lastCount;
        end

        --返回当前字符实际占用的字符数
        function SubStringGetByteCount(str, index)
          local curByte = string.byte(str, index)
          local byteCount = 1;
          if curByte == nil then
            byteCount = 0
           elseif curByte > 0 and curByte <= 127 then
            byteCount = 1
           elseif curByte>=192 and curByte<=223 then
            byteCount = 2
           elseif curByte>=224 and curByte<=239 then
            byteCount = 3
           elseif curByte>=240 and curByte<=247 then
            byteCount = 4
          end
          return byteCount;
        end


        function SubStringUTF8(str, startIndex, endIndex)
          if startIndex < 0 then
            startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
          end

          if endIndex ~= nil and endIndex < 0 then
            endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
          end

          if endIndex == nil then
            return string.sub(str, SubStringGetTrueIndex(str, startIndex));
           else
            return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
          end
        end

        view.date.Text=(SubStringUTF8((datas[position+1]["date"]),1,40))
        view.textto.Text=(SubStringUTF8((datas[position+1]["textto"]),1,100).."...")
        view.roads.Text=(datas[position+1]["roads"])
        view.likes.Text=(datas[position+1]["likes"])

        local function round(边宽度,边框色,背景色,圆角度)
          import "android.graphics.drawable.GradientDrawable"
          drawable = GradientDrawable()
          drawable.setShape(GradientDrawable.RECTANGLE)
          drawable.setStroke(边宽度,tonumber(边框色))
          drawable.setColor(tonumber(背景色))
          drawable.setCornerRadius(圆角度)
          return drawable
        end


        view.卡片.BackgroundDrawable=round(4,to0x(maincolor),to0x(backcolor),20)
        ripples(view.backitem,to0x(maincolor))
        --子项目点击事件
        view.卡片.onClick=function(v)
          local roadt=(datas[position+1]["roads"])
          local titles=(datas[position+1]["date"])
          local texts=(datas[position+1]["textto"])
          -- print(texts)
          local types=(datas[position+1]["likes"])

          --print(roadt)
          redialog.show()
          redialog.setCanceledOnTouchOutside(true);--设置触摸弹窗外部隐藏弹窗
          reviewmd.loadDataWithBaseURL("",md(texts),"text/html","utf-8",nil)
          retitle.setText(titles)
          retitle.setTextColor(to0x(maincolor))

          FakeBold(retitle)

          deletep.setColorFilter(to0x(subcolor))
          editp.setColorFilter(to0x(subcolor))
          sharep.setColorFilter(to0x(subcolor))

          ripples(edits,to0x(subcolor))
          ripples(shares,to0x(subcolor))
          ripples(delete,to0x(subcolor))

          edits.onClick=function()
            this.newActivity("mods/edit",{roadt})
            redialog.dismiss()
          end
          shares.onClick=function()

            items={}
            table.insert(items,"分享文本")
            table.insert(items,"分享文件")
            
            --table.insert(items,"从剪切板导入")
            table.insert(items,"取消操作")
            --列表对话框
            selects=AlertDialog.Builder(this)
            selects.setTitle("选择")
            selects.setItems(items,{onClick=function(l,v)
                if (items[v+1])=="分享文本" then
                  shareText(StrToTable(io.open(roadt):read("*a"))["content"]["title"].."\n\n"..StrToTable(io.open(roadt):read("*a"))["content"]["messages"])
                end
                if (items[v+1])=="分享文件" then
                  shared(roadt,"txt")
                end
            end})
            selects.show()
          end
          delete.onClick=function()
            deles(roadt)
            redialog.dismiss()
          end
          return true
        end
        --子项目里面的控件长按事件
        view.date.onLongClick=function(v)
          print("长按"..v.Text)
          return true
        end
      end,
    }))
    --瀑布流管理器(第一个参数:几行,第二个参数:方向)
    notelist.setLayoutManager(StaggeredGridLayoutManager(2,StaggeredGridLayoutManager.VERTICAL))
    --RecyclerView绑定适配器
    notelist.setAdapter(adapter)
  end
  animation = AnimationUtils.loadAnimation(activity,android.R.anim.fade_in)
  lac = LayoutAnimationController(animation)
  lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
  lac.setDelay(0.7)--单位是秒
  --listView.setAdapter(adp)
  notelist.setLayoutAnimation(lac)
  setwaterfall()
  --Refresh()--防止回调冲突
  FakeBold(title)
  putData("switch","瀑布预先启用","true")






 else
  import"layout.item"
  mainlays.addView(loadlayout ( {
    ListView;
    dividerHeight="0";
    layout_width="fill";
    background=backcolor;
    layout_height="fill";
    id="notelist";
  }
  ))
  --定义列表
  datas={}
  adp=LuaAdapter(activity,datas,item)
  notelist.Adapter=adp
  animation = AnimationUtils.loadAnimation(activity,android.R.anim.fade_in)
  lac = LayoutAnimationController(animation)
  lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
  lac.setDelay(0.7)--单位是秒
  --listView.setAdapter(adp)
  notelist.setLayoutAnimation(lac)


  --Refresh()--防止回调冲突
  FakeBold(title)


  notelist.onItemLongClick=function(l, v, d, p)
    --dele.show()
    --redialog.dismiss()
  end
  notelist.onItemClick=function(l, v, d, p)
    local titles=datas[p].date
    local texts=datas[p].textto
    local types=datas[p].likes
    local roadt=datas[p].roads
    --print(roadt)
    redialog.show()
    redialog.setCanceledOnTouchOutside(true);--设置触摸弹窗外部隐藏弹窗
    reviewmd.loadDataWithBaseURL("",md(texts),"text/html","utf-8",nil)
    retitle.setText(titles)
    retitle.setTextColor(to0x(maincolor))

    FakeBold(retitle)

    deletep.setColorFilter(to0x(subcolor))
    editp.setColorFilter(to0x(subcolor))
    sharep.setColorFilter(to0x(subcolor))

    ripples(edits,to0x(subcolor))
    ripples(shares,to0x(subcolor))
    ripples(delete,to0x(subcolor))

    edits.onClick=function()
      this.newActivity("mods/edit",{roadt})
      redialog.dismiss()
    end
    shares.onClick=function()
      shareText(StrToTable(io.open(roadt):read("*a"))["content"]["title"].."\n\n"..StrToTable(io.open(roadt):read("*a"))["content"]["messages"])
    end
    delete.onClick=function()
      deles(roadt)
      redialog.dismiss()
    end
  end
  putData("switch","瀑布预先启用","false")




end


function selector()
  if getData("switch","瀑布预先启用")=="true" then
    setwaterfall()

   else
    adp=LuaAdapter(activity,datas,item)
    notelist.Adapter=adp
  end
end