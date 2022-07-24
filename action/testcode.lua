--github@sudoskys
 contents=(
          {
            ["date"] ={
              ["create"] ="21.06.09 11:29:37";
              ["update"] ="21.06.09 21:35:58";
            };
            ["content"] ={
              ["color"]=4294967295;
              ["star"]=false,
              ["category"]="分类标签";
              ["title"] ="写写什么";
              ["messages"] =[[## 一级标题
# md文档]];
            };
          }
          )
          contents=dump(contents)
          local c=string.unpack("=",contents)
          --local c=string.unpack(contents) 
          local d=loadstring("return "..c)() 
          print(dump(d))         
