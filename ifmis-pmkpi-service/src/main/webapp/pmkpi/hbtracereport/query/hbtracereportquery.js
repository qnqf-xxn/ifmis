if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.hbtracereportquery = function(config, service){
    var cmp = {};

    var serviceid = service,
        _menuid = config.menuid,
        _tablecode,
        _defquery,
        _orderby,
        _uikey,
        _agency,//左侧树节点;
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    /**
     * 查询
     * @param obj
     */
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    $(function() {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.pmkpi.query = function(){
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.menuid = _menuid;
        params.beanid = "pmkpi.hbtracereport.hbtracereportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 批量导出
     */
    cmp.batchdownload = function(){
        var selDatas = datatable.getSelected();
        if(selDatas.size() <= 0){
            Ext.lt.ui.alert('请选择要导出的数据！', function(){});
            return;
        }
        var _filebustype = "hbtracereportupload";
        var guids = [];
        for(var i=0; i<selDatas.length; i++){
            var _expfileguid = selDatas[i].guid;
            /*var _expfilename = selDatas[i].code+"-"+selDatas[i].name;
            var downloadfileform = "downloadfileform"+i;*/
            guids.push(_expfileguid);
        }
        //sleep(2000);
        exportIndexFile(guids);
    }

    function sleep(numberMillis){
        var now = new Date();
        var exitTiem = now.getTime() + numberMillis;
        while (true){
            now = new Date();
            if(now.getTime() > exitTiem ){
                return;
            }
        }
    }

    exportIndexFile = function (guids) {
        var url = "/pmkpi/trace/uploadreport/hbzip.do?tokenid=" + Ext.lt.token.getTokenid();
        var form=$("<form >");//定义一个form表单
        form.attr("id","downloadfileform");
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post"); //请求类型
        form.attr("action",url); //请求地址
        $("body").append(form);//将表单放置在web中

        var input1=$("<input>");
        input1.attr("type","hidden");
        input1.attr("id","guids");
        input1.attr("name","guids");
        input1.attr("value",guids);
        form.append(input1);

        /*var input2=$("<input>");
        input2.attr("type","hidden");
        input2.attr("id","filebustype");
        input2.attr("name","filebustype");
        input2.attr("value",_filebustype);
        form.append(input2);

        var input3=$("<input>");
        input3.attr("type","hidden");
        input3.attr("id","expfilename");
        input3.attr("name","expfilename");
        input3.attr("value",_expfilename);
        form.append(input3);*/

        form.submit();

        var idObject = document.getElementById("downloadfileform");
        if (idObject != null){
            idObject.parentNode.removeChild(idObject);
        }
    }

    /**
     * 点击树
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _uikey = config.uikey;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = "/pmkpi/hbtracereport/upload/edit.page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.viewtype = "query";
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门监控报告上报");
                };
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = '/pmkpi/hbtracereport/upload/query';
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    return cmp;
}