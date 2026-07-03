if (Ext.lt.pmkpi == null) {
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.auditerror = function(config, service){
    $(function (){
        if (window.parent.Ext.lt.pmkpi.errordata) {
            datatable.setDatas(window.parent.Ext.lt.pmkpi.errordata);
        }
    })

}