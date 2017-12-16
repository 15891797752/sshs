package com.sshs.system.coder.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sshs.core.base.controller.BaseController;
import com.sshs.core.exception.BusinessException;
import com.sshs.core.message.Message;
import com.sshs.core.page.Page;
import com.sshs.core.util.ReflectHelper;
import com.sshs.core.util.Serializabler;
import com.sshs.system.coder.helper.CodeGenerator;
import com.sshs.system.coder.model.Coder;
import com.sshs.system.coder.model.Column;
import com.sshs.system.coder.model.DbTable;
import com.sshs.system.coder.service.ICoderService;
import com.sshs.system.coder.service.IDbTableService;

/**
 * 类名称： 代码生成器
 * 
 * @author Suny
 * @date 2017年10月23日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/system/coder")
public class CoderController extends BaseController {
	Logger logger = Logger.getLogger(CoderController.class);
	@Resource(name = "coderService")
	private ICoderService coderService;
	@Resource(name = "dbTableService")
	private IDbTableService dbTableService;

	/**
	 * 獲取表列表
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTableList.do")
	@ResponseBody
	public Page<DbTable> getTableList(@RequestBody Page<DbTable> page, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return dbTableService.findForPageList("com.sshs.system.coder.dao.CoderDao.findDbTableForPageList", page);
	}

	/**
	 * 獲取字段列表
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getColunmList.do")
	@ResponseBody
	public Page<Column> getColunmList(@RequestBody Page<Column> page, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		coderService.findColumnForList(page);
		return page;
	}

	/**
	 * 生成代码
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/runCoder.do")
	@ResponseBody
	public Message runCoder(@RequestBody Coder coder, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			for (Column col : coder.getFields()) {
				if (StringUtils.isEmpty(coder.getTableName())) {
					coder.setTableName(col.getTableName());
					coder.setTableComment(col.getTableComment());
				}
				col.setPropertyName(ReflectHelper.getPropertyName(col.getColumnName()));
				col.setPropertyType(CodeGenerator.getPropertyType(col.getColumnType()));

				/*// 主键使用UUID，页面不控制非空验证
				if ("Y".equalsIgnoreCase(col.getPrimaryKeyFlag())) {
					col.setRequiredFlag("Y");
				}*/
			}

			coder.setColumns(Serializabler.object2Bytes(coder.getFields()));

			CodeGenerator.generate(coder);
			coderService.save(coder);
			return new Message("0000", "成功！");
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("-10001", "代码生成出错！");
		}
	}
}