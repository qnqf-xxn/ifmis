if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.auditservice = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _mainguid = config.mainguid,
        _jxback = config.jxback,//绩效退回初始节点标识
        _jxaudit = config.jxaudit,
        _audittype =config.audittype,
        _agency = config.agency,
        _nodeguid = config.nodeguid,
        _workflow = config.workflow;

    window.parent.Ext.lt.pmkpi.childwindow = window;



    cmp.query = function () {
        Ext.lt.ui.loadingShow();
        var parms = {};
        parms.mainguid = _mainguid;
        parms.audittype = _audittype;
        parms.agency = _agency;
        parms.workflow = _workflow;
        parms.nodeguid = _nodeguid;
        Ext.lt.RCP.call("/pmkpi/audit/index/opinion/auditinfo", "query", parms, function(rt){
            if(_jxaudit == "jxaudit"){
                sxdatatable.setDatas(rt.datas);
                sxdatatable.resize(document.body.clientWidth,300);
            }
            Ext.lt.ui.loadingClose();
        }, function(){
            Ext.lt.ui.loadingClose();
        });
    }


    /**
     * 确定
     */
    cmp.confirm = function () {
        var datas = parent.datatable.getSelected();
        var params = {};
        params = editform.getEditFormValues();
        params.datas = datas;
        var tst = Object.keys(config);
        for(var j = 0,len=tst.length; j < len; j++) {
            var vualue = config[tst[j]];
            if (isString(vualue) || isNumber((vualue))) {
                params[tst[j]] = vualue;
            }
        }
        parent.Ext.lt.pmkpi.auditdata = null;
        window.parent.Ext.lt.pmkpi.sendWFAction(params);
    }

    /**
     * 确定
     */
    cmp.adjdelconfirm = function () {
        var params = {};
        params = editform.getEditFormValues();
        var tst = Object.keys(config);
        for(var j = 0,len=tst.length; j < len; j++) {
            var vualue = config[tst[j]];
            if (isString(vualue) || isNumber((vualue))) {
                params[tst[j]] = vualue;
            }
        }
        window.parent.Ext.lt.pmkpi.delWFAction(params);
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    }

    $(function () {
        if (_jxback == null || _jxback =="false"){
            common.changTooltoolbuttontStatus(0, "退回单位");
        }
        if(_jxaudit == "jxaudit"){
            cmp.query();
        }
    })

    /**
     * 项目绩效目标审核(绩效处退回)
     */
    cmp.backjxaudit = function(obj){
        ajax();
    }


    function ajax() {
        var remark=editform.getEditFormValues().remark;
        var selUrl = "/pmkpi/doubleprocess/backDoublePress.do?tokenid="+Ext.lt.token.getTokenid();
        var datas = parent.datatable.getSelected();
        var list = [];
        for (var i=0; i<datas.length;i++) {
            list.push({
                "mainguid": datas[i].pro_id,
                "pro_code": datas[i].pro_code,
                "remark": remark
            });
        }
        var params = {};
        params.backData = JSON.stringify(list);
        params.remark = remark;
        $.ajax({
            type: "post",
            url: selUrl,
            data: JSON.stringify(params),
            dataType: "text",
            contentType: "application/json",
            success: function (data) {
                var data = JSON.parse(data);
                if (true== data.result) {

                    Ext.lt.ui.alert(("退回成功！"),{}, function(ret) {
                        parent.Ext.lt.ui.modalWindow.close()
                    });
                    Ext.lt.message.send("perfcommon", "auditquery",{});
                    Ext.lt.ui.closeModalWindow;
                } else {
                    Ext.lt.ui.alert('退回失败！',function(){
                    });
                }
                Ext.lt.ui.loadingClose();
            }
        });
    }


    return cmp;
}