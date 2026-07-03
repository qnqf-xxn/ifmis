if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
Ext.lt.pmkpi.proallinfo = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
     var cmp = {};
     var
         pro_code = config.pro_code,
         proguid = config.proguid,
         scrWidth = document.body.clientWidth,
         scrHeight = document.body.clientHeight;

    /**
     * 页面加载完成执行
     */
    $(function () {
        cmp.query();
        //隐藏不必要的监控分析区域.
        var ids = ["monitoreditform1", "monitoreditform2", "monitoreditform3", "monitoreditform4", "monitoreditform5"];
        ids.forEach(function(id) {
            if (!lefttree.qtree.getNode(id)) {
                document.getElementById(id).style.display = 'none';
            }
        });
        setTimeout(function () {
            if(_SYSTEMSTYLE_ == "grey"){
                $(".edittitle").find(".title").css("margin","10px 0 10px");// 编辑区标题样式调整
                var allrightdiv = $(".tpl_right").children("div");// 解决内部编辑区div高度行内样式被覆盖问题，提级
                for (var i=0; i<allrightdiv.length; i++) {
                    if(allrightdiv[i].id.indexOf("editform") != -1){
                        var height = allrightdiv[i].style.height;
                        if (height) {
                            var currentStyle = allrightdiv[i].style.cssText;
                            allrightdiv[i].style.cssText = currentStyle + ' height: '+height +' !important;';
                        }
                    }
                }
            }
        }, 500);
    });

    cmp.query = function (){
        //1获取左侧树节点
        var nodes = lefttree.cfg.datas;
        var tempguid = "";
        if(nodes){
            var params = {};
            params.pro_code = pro_code;
            params.proguid = proguid;
            Ext.lt.RCP.call(service, "getAllData", params, function (rs) {
                if (rs.flg == "1"){
                    nodes.forEach(function(element) {   //异步加载，互不影响
                        if (element["isleaf"] == 1){
                            tempguid = element.guid;
                            if(tempguid.indexOf("editform") > -1){
                                if(eval(tempguid)){
                                    eval(tempguid).synchEditformByObj(rs[tempguid].data);
                                }
                                var cols = eval(tempguid).cfg.data;
                                var c = {};
                                for (var i=0; i<cols.length; i++) {
                                    if(cols[i].isvisiable==1){
                                        c[cols[i].colcode.toLowerCase()] = true;
                                    }
                                }
                                eval(tempguid).setdisabled(c);//设置基本信息不可编辑
                            }
                            if(tempguid.indexOf("datatable") > -1){
                                cmp.setTableColum(tempguid);
                                //处理年度绩效添加的自评值字段
                                if(tempguid == "yeardatatable"){
                                    var columns  = yeardatatable.getCols();
                                    columns.push({
                                        name:"actualvalue",
                                        alias:"自评完成值",
                                        colcode:"actualvalue",
                                        coltype :1,
                                        display:true,
                                        edit:true,
                                        iseditctrl: null,
                                        issource:"",
                                        isvisiable: 1,
                                        datatype:'S',
                                        ordernum:5,
                                        width:120,
                                        minwidth:100
                                    });
                                    yeardatatable.setColumns(columns);
                                    yeardatatable.redraw();
                                }
                                if (eval(tempguid)){
                                    eval(tempguid).setDatas(rs[tempguid].data);
                                }
                            }
                        }
                    });
                }
            });
        }
        // nodes.forEach(function(element) {   //异步加载，互不影响
        //     if (element["isleaf"] == 1){
        //         var params = {};
        //         tempguid = element.guid;
        //         params.guid = tempguid;
        //         params.code = element.code;
        //         params.pro_code = pro_code;
        //         params.proguid = proguid;
        //         if(tempguid.indexOf("editform") > -1){
        //             Ext.lt.RCP.call(service, "editQuery", params, function (rs) {
        //                 if (rs.flg == "1"){
        //                     eval(element.guid).synchEditformByObj(rs.data);
        //                 }
        //                 var cols = eval(element.guid).cfg.data;
        //                 var c = {};
        //                 for (var i=0; i<cols.length; i++) {
        //                     if(cols[i].isvisiable==1){
        //                         c[cols[i].colcode.toLowerCase()] = true;
        //                     }
        //                 }
        //                 eval(element.guid).setdisabled(c);//设置基本信息不可编辑
        //             }, function () {
        //                 Ext.lt.ui.alert('查询异常！', function () {
        //                 });
        //             });
        //         }
        //         if(tempguid.indexOf("datatable") > -1){
        //             Ext.lt.RCP.call(service, "datableQuery", params, function (rs) {
        //                 //处理年度绩效添加的自评值字段
        //                 if(element.guid == "yeardatatable"){
        //                     var columns  = yeardatatable.getCols();
        //                     columns.push({
        //                         name:"actualvalue",
        //                         alias:"自评完成值",
        //                         colcode:"actualvalue",
        //                         coltype :1,
        //                         display:true,
        //                         edit:true,
        //                         iseditctrl: null,
        //                         issource:"",
        //                         isvisiable: 1,
        //                         datatype:'S',
        //                         ordernum:5,
        //                         width:120,
        //                         minwidth:100
        //                     });
        //                     yeardatatable.setColumns(columns);
        //                     yeardatatable.redraw();
        //                 }
        //                 if (rs.flg == "1"){
        //                     eval(element.guid).setDatas(rs.data);
        //                 }
        //             }, function () {
        //                 Ext.lt.ui.alert('查询异常！', function () {
        //                 });
        //             });
        //         }
        //     }
        // });
    }

    cmp.setTableColum = function (datatablestr) {
        var datatableobj = eval(datatablestr);
        var cols = datatableobj.getCols(); //获取列表所有列
        for (var i = 0, len = cols.length; i < len; i++) {
            if (cols[i].colcode == "obligate1") {
                cols[i].display = false; //display置为false，隐藏
                continue;
            }
        }
        datatableobj.setSelfdefconfig({config: "{}"});
        datatableobj.redraw(); //从新绘制表格
        perfcommon.initDatatable(datatableobj);
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode && treeNode.isleaf == 1){
            window.location.hash = "#"+treeNode.guid;
        } else {
            Ext.lt.ui.alert('请选择末级业务节点！', function () {
            });
        }
    });

    return cmp;
}