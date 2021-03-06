/**
 * bootstrapTable ajax获取后台数据 paginator插件扩展，以增加通用性
 * 
 * @author:Suny
 * @date:2017-10-10
 */
$.fn
		.extend({
			/**
			 * bootstrapTable 扩展 初始化及加载数据
			 */
			loadTableData : function(params) {
				if (!params) {
					params = {};
				} else {
					var operators = {};
					for ( var name in params) {
						var element = $("[name='" + name + "']");
						if (element.attr("preAddonValue") && params[name]) {
							operators[name] = element.attr("preAddonValue");
							if (element.attr("preAddonValue").indexOf("like") >= 0) {
								params[name] = "%" + params[name] + "%";
							}
						}
					}
					params = {
						"variables" : params,
						"operators" : operators
					};
				}
				$(this).bootstrapTable("destroy");
				var columns;
				if (typeof $(this).data("columns") === 'string') {
					columns = JSON.parse($(this).data("columns").replace(/\'/g,
							"\""));
				} else {
					columns = $(this).data("columns");
				}
				if (typeof params === 'string') {
					params = JSON.parse(params);
				}
				var tableObject = $(this);

				var tableargs = {
					url : $(this).data("url") ? $(this).data("url") : "", // 请求后台的URL（*）
					method : $(this).data("method") ? $(this).data("method")
							: 'post', // 请求方式（*）
					toolbar : $(this).data("toolbar") ? '#'
							+ $(this).data("toolbar") : '#toolbar', // 工具按钮用哪个容器
					striped : $(this).data("striped") ? $(this).data("striped")
							: false, // 是否显示行间隔色
					cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					pagination : $(this).data("pagination") ? $(this).data(
							"pagination") : false, // 是否显示分页（*）
					sortable : true, // 是否启用排序
					sortName : $(this).data("sortName"), // 初始化的时候排序的字段
					sortOrder : $(this).data("sortOrder"), // 排序方式
					queryParams : params, // 传递参数（*）
					sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
					contentType : "application/json", // "application/x-www-form-urlencoded",
					// //请求数据内容格式 默认是
					// application/json
					// 自己根据格式自行服务端处理
					dataType : "json", // 期待返回数据类型
					pageNumber : 1, // 初始化加载第一页，默认第一页
					pageSize : $(this).data("pageSize") ? $(this).data(
							"pageSize") : 10, // 每页的记录行数（*）
					pageList : $(this).data("pageList") ? $(this).data(
							"pageList") : [ 5, 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
					// search : true, //
					// 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
					// strictSearch : true,
					dataField : "rows",
					totalField : "totalCount",
					showColumns : true, // 是否显示所有的列
					showRefresh : true, // 是否显示刷新按钮
					minimumCountColumns : 2, // 最少允许的列数
					clickToSelect : true, // 是否启用点击选中行
					// height : 500,
					// //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
					// uniqueId : "ID", // 每一行的唯一标识，一般为主键列
					showToggle : $(this).data("showToggle") ? $(this).data(
							"showToggle") : false, // 是否显示详细视图和列表视图的切换按钮
					// cardView : false, //是否显示详细视图
					// detailView : false, //是否显示父子表
					columns : columns,
					onPostBody : function() {
						tableObject.find(".form-select2").select2({
							theme : "bootstrap",
							width : 'resolve'
						});
						tableObject.find('.form-switch').bootstrapSwitch();
					}
				};
				if ($(this).data("tree-field")) {
					tableargs = {
						url : $(this).data("url") ? $(this).data("url") : "", // 请求后台的URL（*）
						method : $(this).data("method") ? $(this)
								.data("method") : 'post', // 请求方式（*）
						idField : $(this).data("tree-id"),
						treeShowField : $(this).data("tree-field"),
						parentIdField : $(this).data("parent-field"),
						pagination : false,
						onLoadSuccess : function(data) {
							tableObject
									.treegrid({
										initialState : 'collapsed',// 收缩
										treeColumn : tableObject
												.data("tree-field-index"),// 指明第几列数据改为树形
										expanderExpandedClass : 'glyphicon glyphicon-triangle-bottom',
										expanderCollapsedClass : 'glyphicon glyphicon-triangle-right',
										onChange : function() {
											tableObject.bootstrapTable('resetWidth');
										}
									});
						}
					};
				}
				$(this).bootstrapTable(tableargs);
			},
			/**
			 * bootstrapTable扩展方法 获取编辑后的数据
			 */
			getTableData : function(useCurrentPage) {
				var data1 = $(this).bootstrapTable('getData', useCurrentPage);
				if (data1 && data1.constructor === Array) {
					var elements = $(this).find("[index],[field]");
					if (elements && elements.length > 0) {
						var data2 = JSON.stringify(data1);// 实现对象复制
						var data = JSON.parse(data2);
						for (var x = 0; x < elements.length; x++) {
							var element = elements.get(x);
							if (element && element.tagName == 'INPUT'
									|| element.tagName == "SELECT") {
								var value = null;
								if (element.tagName == 'INPUT'
										&& element.className
										&& element.className
												.indexOf("form-switch") >= 0) {
									value = $(element).bootstrapSwitch('state');
								} else {
									value = element.value;
								}
								if (data[parseInt(element.getAttribute("index"))]) {
									data[parseInt(element.getAttribute("index"))][element
											.getAttribute("field")] = value;
								}
							}
						}
						return data;
					}
				}
				return data1;
			}
		});

/**
 * 单元格渲染
 */
var _EditorRender = function(value, row, index, name, format) {
	var editor = $(format);
	editor.attr("index", index);
	editor.attr("field", name);
	if (!value && editor.attr("defaultValue")) {
		value = editor.attr("defaultValue");
	}
	if (editor.is('input') && editor.attr("type") === "text") {
		editor.attr("value", value);
	}

	if (editor.is('input') && editor.attr("type") === "checkbox") {
		if (editor.hasClass("form-switch")) {
			// editor.bootstrapSwitch("state", value=="on");
			if (value == "on") {
				value = true;
			}
			if (value == "off") {
				value = false;
			}
		}
		editor.attr("checked", value);
	}

	if (editor.is('select')) {
		var options = editor.filter("option");
		options.each(function(option) {
			if (option.val() == value) {
				options.attr("selected", true);
			}
		});
	}
	if (editor.is('button')) {
		editor.attr("onclick", "javascript:" + editor.attr("action") + "("
				+ JSON.stringify(row, function(key, value) {
					if (key === '_nodes') {
						return null;
					}
					return value;
				}) + ");");
	}
	return editor.get(0).outerHTML;
};