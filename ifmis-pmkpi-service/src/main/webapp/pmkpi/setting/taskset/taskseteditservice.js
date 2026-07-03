if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.tasksetservice)
    Ext.lt.pmkpi.tasksetservice = {};

Ext.lt.pmkpi.tasksetservice = function(config, service){
    var cmp = {};
    var _treeid = config.treeid,
        _bustype = config.bustype,//业务类型
        _pagetype = config.pagetype;//修改/新增
        window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function () {
        if (_pagetype == "mod") {
            editform.synchEditformByObj(config.taskdata);
        } else {
            var data = {};
            data.bustype = _bustype;
            data.tasktype = _treeid;
            editform.synchEditformByObj(data);
        }
    })

    cmp.infosave = function () {
        if (!editform.check()) return;//先校验
        //判断开始时间与结束时间的前后
        var stime = editform.getCol("startdate").getvalue();
        var etime = editform.getCol("enddate").getvalue();
        if (parseInt(stime) > parseInt(etime)){
            Ext.lt.ui.alert('开始时间不能大于结束时间！', function () {
                return;
            });
            return;
        }
        var params = {};
        params.pagetype = _pagetype;
        params.data = editform.getEditFormValues();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    parent.Ext.lt.pmkpi.query();
                    Ext.lt.ui.closeModalWindow();
                });
            } else {
                Ext.lt.ui.alert('保存失败！',function(){
                });
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }
    return cmp;
}