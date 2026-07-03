if (Ext.lt.pmkpi == null) {
    Ext.lt.pmkpi = {};
}
//初始化页面
var serviceid;
Ext.lt.pmkpi.deptselpros = function(config, service) {
    var cmp = {};
    serviceid = service;
    var _saveAgency =  config.saveAgency;
    var _mainguid =  config.mainguid;
    var _indexguid =  config.indexguid;
    var _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;

    var projets =config["projects"]; //部门项目

    var nodata = []; //带选择项目
    var yesdata = []; //已经选择项目
    //页面加载后执行构建页面
    $(document).ready(function(){
        //构造头部页面
        Ext.lt.pmkpi.initMainDiv();
        //捕获页面按钮信息
        Ext.lt.message.hook("rightmove",'editform',function(resp){
            move('right');
        });
        Ext.lt.message.hook("leftmove",'editform',function(resp){
            move('left');
        });
        yeseltable.draw(ytable_div);
        noseltable.draw(ntable_didv);
        var tempwidth = $("#ytable_div").width();
        yeseltable.resize(tempwidth,_scrHeight-20);
        noseltable.resize(tempwidth,_scrHeight-20);
        // 判断部门项目表数据是否存在
        var indexprojects = parent.indexprojects; //指标选中的项目
        var selguids = "";
        if (indexprojects.length > 0){
            for (var i = 0; i < indexprojects.length; i++) {
                selguids = selguids +","+ indexprojects[i]["pro_code"];
            }
        }
        var tempproid = "";
        for (var i = 0; i < projets.length; i++) {
            tempproid = projets[i]["pro_code"];
            if (selguids.indexOf(tempproid) > -1) {
                yesdata.push(projets[i]);
            } else {
                nodata.push(projets[i]);
            }
        }
        yeseltable.setDatas(yesdata);
        noseltable.setDatas(nodata);
    });
    //右侧区域填写html脚本
    Ext.lt.pmkpi.initMainDiv = function() {
        var headhtml = ' <div id="main_div" width= "700px"> ';
        headhtml += ' <table width="100%" heigth="460px" border="0"> ';
        headhtml += ' <tr><th width="45%" align="left"><span>&nbsp;待选项目：</span></th><th width="10%"></th><th width="45%" align="left">&nbsp;已选项目：</th></tr> ';
        headhtml += '<tr><td colspan="3" height="6px"></td></tr>';
        //headhtml += ' <tr><td><div style="background:#FFFFFF;width:100%;height:300px;border:1px solid #e5e5e5;" id="ntable_didv" name="ntable_didv"';
        headhtml += ' <tr><td><div id="ntable_didv"  name="ntable_didv"';
        headhtml += ' </div></td><td> ';
        headhtml += ' <div id="center_div" style="margin-left:20px;"> ';
        headhtml += ' </div></td><td> ';
        headhtml += ' <div id="ytable_div"></div></td> ';
        headhtml += ' </tr></table>';
        headhtml += ' </div> ';
        $(".bd_main").append(headhtml);
        $(".bd_main").css("overflow","hidden");
        //处理中间的按钮
        var buttons=[];
        buttons.push(
            {name:'rightmove',title:'右移',icon:'rightmove',
                action:function(){
                    Ext.lt.message.send("rightmove", "editform");
                },disabled:false
            });
        buttons.push(
            {name:'leftmove',title:'左移',icon:'leftmove',
                action:function(){
                    Ext.lt.message.send("leftmove", "editform");
                },disabled:false
            });
        var btns = new Ext.lt.ui.toolbuttonbar({data:{buttons:buttons}});
        btns.draw(document.getElementById("center_div"));
        $("#center_div").find("li").css("margin-top","12px");
    }
    /**
     * 移动要素操作
     * @param type - 操作方式
     */
    function move(type) {
        if (type == "right") {
            var seldata = noseltable.getSelected();
            if (seldata.length == 0){
                Ext.lt.ui.alert('请选择要选中的项目！',function(){});
                return false;
            }
            var tempdata = Ext.lt.cloneobj(seldata);
            yeseltable.getRecordSet().addData(tempdata,99);
            noseltable.removeSelected();
        } else if (type == "left") { //左移
            var seldata = yeseltable.getSelected();
            if (seldata.length == 0){
                Ext.lt.ui.alert('请选择要移除的项目！',function(){});
                return false;
            }
            var tempdata = Ext.lt.cloneobj(seldata);
            noseltable.getRecordSet().addData(tempdata,99);
            yeseltable.removeSelected();
        }
    }

    /**
     * 关闭窗口
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    /**
     * 确定
     */
    cmp.savepros = function () {
        var seldata = yeseltable.getRecordSet().toArray();
        var tempprojs = [];
        for (var i = 0; i < seldata.length; i++) {
            seldata[i]["indexguid"] = _indexguid;
            tempprojs.push(seldata[i]);
        }
        var parent_sel_rows = parent.perfindexdatatable.getRecordset().query({guid:_indexguid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["projects"] = tempprojs;
        parent_sel_obj["projmod"] = 'mod'; //指标对应项目发生变动.
        parent.perfindexdatatable.reflash(_sortid);
        parent.perfindexdatatable.updateData(_sortid,"proselect","1111");
        parent.Ext.lt.ui.modalWindow.close();
    }

    return cmp;
}
