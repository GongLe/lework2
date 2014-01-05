/**
 *  [ {
  "id" : "idddddd",
  "text" : "集团",
  "state" : "open",
  "checked" : false,
  "iconCls" : null,
  "attributes" : {
    "code" : "jituan"
  } , "children" : [ ....]
  }
 ]
 *把easyui tree json data 转换成html select <option>
 *
 * @param data 1.json array数组;2.也可以是jQuery ajax 配置信息  Json Array ,Json Object
 * @param checkedNode checked节点 String ,Array
 */
var makeAsOptions = function (data, checkedNode, nonValText, indent) {
    var html = '<option value="">' + nonValText ? nonValText : '' + '</option>';
    var _ajaxOpt , _checkedNodeArr = $.isArray(checkedNode) ? checkedNode : ([checkedNode]);
    if ($.isPlainObject(data)) {
        _ajaxOpt = { dataType: 'json', success: function (resp, textStatus, XMLHttpRequest) {
            var node;
            for (var i = 0; i < resp.length; i++) {
                node = resp[i];
                html += '<option ' + _checkedNodeArr.indexOf(node.id) != -1 ? ('selected="selected" ') : '' + ' value=\"' + node.id + '\"  >' + node.text + '</option>';
                //has child
                _fetchChild(node, checkedNode, html, indent);
                console.log(html)
            }
        }, error: function () {

        }}
        $.ajax($.extend(_ajaxOpt, data));
    } else {
        $.Error('makeAsOptions配置信息有误.');
        return false;
    }

}

var _fetchChild = function (parentNode, checkedNode, html, indent) {
    var nodeChild = parentNode.children;
    if ($.isArray(nodeChild) && nodeChild.length > 0) {
        var node;
        for (var i = 0; i < nodeChild.length; i++) {
            node = nodeChild[i];
            html += '<option ' + checkedNode.indexOf(node.id) != -1 ? ('selected="selected" ') : '' + ' value=\"' + node.id + '\"  >' + indent + node.text + '</option>';
            //has child
            _fetchChild(node, checkedNode, html, indent += indent);
        }
    } else {
        return;
    }
}
/// =============== test ==================

var testData = [
    {
        "id": "2c9f84db426eb16801426ee6796b0000",
        "text": "集团",
        "state": "open",
        "checked": false,
        "iconCls": null,
        "attributes": {
            "code": "jituan"
        },
        "children": [
            {
                "id": "2c9f84db426eb16801426ee78d0e0001",
                "text": "测试区域",
                "state": "open",
                "checked": false,
                "iconCls": null,
                "attributes": {
                    "code": "jituan.01"
                },
                "children": [
                    {
                        "id": "2c9f84db426eb16801426ee83a9a0002",
                        "text": "上海分公司",
                        "state": "open",
                        "checked": false,
                        "iconCls": null,
                        "attributes": {
                            "code": "jituan.01.01"
                        },
                        "children": [ ]
                    },
                    {
                        "id": "2c9f84db426eb16801426ee91c4f0003",
                        "text": "湖南分公司",
                        "state": "open",
                        "checked": false,
                        "iconCls": null,
                        "attributes": {
                            "code": "jituan.01.02"
                        },
                        "children": [ ]
                    }
                ]
            }
        ]
    }
];
makeAsOptions(testData, [], '请选择', '--');