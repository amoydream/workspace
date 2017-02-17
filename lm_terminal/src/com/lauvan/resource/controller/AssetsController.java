package com.lauvan.resource.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.interceptor.Perm;
import com.lauvan.resource.entity.R_Res_Bazaar;
import com.lauvan.resource.entity.R_Res_Busstation;
import com.lauvan.resource.entity.R_Res_Company;
import com.lauvan.resource.entity.R_Res_Entertainment;
import com.lauvan.resource.entity.R_Res_Hospital;
import com.lauvan.resource.entity.R_Res_Reservoir;
import com.lauvan.resource.entity.R_Res_School;
import com.lauvan.resource.entity.R_Res_Square;
import com.lauvan.resource.entity.R_Res_Supermarket;
import com.lauvan.resource.entity.R_Res_Uptown;
import com.lauvan.resource.service.ResBazaarService;
import com.lauvan.resource.service.ResBusstationService;
import com.lauvan.resource.service.ResCompanyService;
import com.lauvan.resource.service.ResEntertainmentService;
import com.lauvan.resource.service.ResHospitalService;
import com.lauvan.resource.service.ResReservoirService;
import com.lauvan.resource.service.ResSchoolService;
import com.lauvan.resource.service.ResSquareService;
import com.lauvan.resource.service.ResSupermarketService;
import com.lauvan.resource.service.ResUptownService;
import com.lauvan.resource.vo.ResBazaarVo;
import com.lauvan.resource.vo.ResBusstationVo;
import com.lauvan.resource.vo.ResCompanyVo;
import com.lauvan.resource.vo.ResEntertainmentVo;
import com.lauvan.resource.vo.ResHospitalVo;
import com.lauvan.resource.vo.ResReservoirVo;
import com.lauvan.resource.vo.ResSchoolVo;
import com.lauvan.resource.vo.ResSquareVo;
import com.lauvan.resource.vo.ResSupermarketVo;
import com.lauvan.resource.vo.ResUptownVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/assets")
public class AssetsController extends BaseController {

	@Autowired
	private ResSchoolService resSchoolService;
	
	@Autowired
	private ResSquareService resSquareService;

	@Autowired
	private ResBazaarService resBazaarService;
	
	@Autowired
	private ResSupermarketService resSupermarketService;
	
	@Autowired
	private ResHospitalService resHospitalService;
	
	@Autowired
	private ResReservoirService resReservoirService;
	
	@Autowired
	private ResUptownService resUptownService;
	
	@Autowired
	private ResCompanyService resCompanyService;
	
	@Autowired
	private ResBusstationService resBusstationService;
	
	@Autowired
	private ResEntertainmentService resEntertainmentService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/resource/assets/assets_main";
	}

	@MethodLog(description = "资源添加")
	@Perm(privilegeValue = "addip")
	@RequestMapping("/addip")
	public String addip(Integer type) {
		if (!ValidateUtil.isEmpty(type)) {
			switch (type){
			case 10 :{
		        return "jsp/resource/assets/square_add";
			}
			case 1 :{
			    return "jsp/resource/assets/school_add";
				}
			case 2 :{
			    return "jsp/resource/assets/bazaar_add";
				}
			case 3 :{
			    return "jsp/resource/assets/supermarket_add";
				}
			case 4 :{
			    return "jsp/resource/assets/hospital_add";
				}
			case 5 :{
			    return "jsp/resource/assets/reservoir_add";
				}
			case 6 :{
			    return "jsp/resource/assets/uptown_add";
				}
			case 7 :{
			    return "jsp/resource/assets/company_add";
				}
			case 8 :{
			    return "jsp/resource/assets/busstation_add";
				}
			case 9 :{
			    return "jsp/resource/assets/entertainment_add";
				}
			}
		}
		return null;
	}

	@RequestMapping("/squareAdd")
	@ResponseBody
	public Json squareAdd(R_Res_Square res) {
		try {
			resSquareService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/schoolAdd")
	@ResponseBody
	public Json schoolAdd(R_Res_School res) {
		try {
			resSchoolService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/bazaarAdd")
	@ResponseBody
	public Json bazaarAdd(R_Res_Bazaar res) {
		try {
			resBazaarService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/supermarketAdd")
	@ResponseBody
	public Json supermarketAdd(R_Res_Supermarket res) {
		try {
			resSupermarketService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/hospitalAdd")
	@ResponseBody
	public Json hospitalAdd(R_Res_Hospital res) {
		try {
			resHospitalService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/reservoirAdd")
	@ResponseBody
	public Json reservoirAdd(R_Res_Reservoir res) {
		try {
			resReservoirService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/uptownAdd")
	@ResponseBody
	public Json uptownAdd(R_Res_Uptown res) {
		try {
			resUptownService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/companyAdd")
	@ResponseBody
	public Json companyAdd(R_Res_Company res) {
		try {
			resCompanyService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/busstationAdd")
	@ResponseBody
	public Json busstation(R_Res_Busstation res) {
		try {
			resBusstationService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	
	@RequestMapping("/entertainmentAdd")
	@ResponseBody
	public Json entertainmentAdd(R_Res_Entertainment res) {
		try {
			resEntertainmentService.save(res);
			return json(true, "添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("添加失败");
		}
	}
	

	@RequestMapping("/editip")
	public String editip(Integer id, Integer type, Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			switch (type){
			case 10 :{
				R_Res_Square square = resSquareService.find(id);
				model.addAttribute("square", square);
				return "jsp/resource/assets/square_edit";
			}
			case 1 :{
				R_Res_School school = resSchoolService.find(id);
				model.addAttribute("school", school);
				return "jsp/resource/assets/school_edit";
			}
			case 2 :{
				R_Res_Bazaar bazaar = resBazaarService.find(id);
				model.addAttribute("bazaar", bazaar);
				return "jsp/resource/assets/bazaar_edit";
			}
			case 3 :{
				R_Res_Supermarket supermarket = resSupermarketService.find(id);
				model.addAttribute("supermarket", supermarket);
				return "jsp/resource/assets/supermarket_edit";
			}
			case 4 :{
				R_Res_Hospital hospital = resHospitalService.find(id);
				model.addAttribute("hospital", hospital);
				return "jsp/resource/assets/hospital_edit";
			}
			case 5 :{
				R_Res_Reservoir reservoir = resReservoirService.find(id);
				model.addAttribute("reservoir", reservoir);
				return "jsp/resource/assets/reservoir_edit";
			}
			case 6 :{
				R_Res_Uptown uptown = resUptownService.find(id);
				model.addAttribute("uptown", uptown);
				return "jsp/resource/assets/uptown_edit";
			}
			case 7 :{
				R_Res_Company company = resCompanyService.find(id);
				model.addAttribute("company", company);
				return "jsp/resource/assets/company_edit";
			}
			case 8 :{
				R_Res_Busstation busstation = resBusstationService.find(id);
				model.addAttribute("busstation", busstation);
				return "jsp/resource/assets/busstation_edit";
			}
			case 9 :{
				R_Res_Entertainment entertainment = resEntertainmentService.find(id);
				model.addAttribute("entertainment", entertainment);
				return "jsp/resource/assets/entertainment_edit";
			}
			}
		}
		return null;
	}
	
	
	@RequestMapping("/schoolEdit")
	@ResponseBody
	public Json schoolEdit(ResSchoolVo resSchoolVo) {
		R_Res_School res = resSchoolService.find(resSchoolVo.getSc_Id());
		BeanUtils.copyProperties(resSchoolVo, res);
		try {
			resSchoolService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/squareEdit")
	@ResponseBody
	public Json squareEdit(ResSquareVo resSquareVo) {
		R_Res_Square res = resSquareService.find(resSquareVo.getSq_Id());
		BeanUtils.copyProperties(resSquareVo, res);
		try {
			resSquareService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/bazaarEdit")
	@ResponseBody
	public Json bazaarEdit(ResBazaarVo resBazaarVo) {
		R_Res_Bazaar res = resBazaarService.find(resBazaarVo.getBa_Id());
		BeanUtils.copyProperties(resBazaarVo, res);
		try {
			resBazaarService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/supermarketEdit")
	@ResponseBody
	public Json supermarketEdit(ResSupermarketVo resSupermarketVo) {
		R_Res_Supermarket res = resSupermarketService.find(resSupermarketVo.getSu_Id());
		BeanUtils.copyProperties(resSupermarketVo, res);
		try {
			resSupermarketService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/hospitalEdit")
	@ResponseBody
	public Json hospitalEdit(ResHospitalVo resHospitalVo) {
		R_Res_Hospital res = resHospitalService.find(resHospitalVo.getHo_Id());
		BeanUtils.copyProperties(resHospitalVo, res);
		try {
			resHospitalService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/reservoirEdit")
	@ResponseBody
	public Json reservoirEdit(ResReservoirVo resReservoirVo) {
		R_Res_Reservoir res = resReservoirService.find(resReservoirVo.getRe_Id());
		BeanUtils.copyProperties(resReservoirVo, res);
		try {
			resSchoolService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/uptownEdit")
	@ResponseBody
	public Json uptown(ResUptownVo resUptownVo) {
		R_Res_Uptown res = resUptownService.find(resUptownVo.getUp_Id());
		BeanUtils.copyProperties(resUptownVo, res);
		try {
			resUptownService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/companyEdit")
	@ResponseBody
	public Json companyEdit(ResCompanyVo resCompanyVo) {
		R_Res_Company res = resCompanyService.find(resCompanyVo.getCo_Id());
		BeanUtils.copyProperties(resCompanyVo, res);
		try {
			resCompanyService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/busstationEdit")
	@ResponseBody
	public Json busstationEdit(ResBusstationVo resBusstationVo) {
		R_Res_Busstation res = resBusstationService.find(resBusstationVo.getBu_Id());
		BeanUtils.copyProperties(resBusstationVo, res);
		try {
			resBusstationService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	@RequestMapping("/entertainmentEdit")
	@ResponseBody
	public Json entertainmentEdit(ResEntertainmentVo resEntertainmentVo) {
		R_Res_Entertainment res = resEntertainmentService.find(resEntertainmentVo.getEn_Id());
		BeanUtils.copyProperties(resEntertainmentVo, res);
		try {
			resSchoolService.update(res);
			return json(true, "编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("编辑失败");
		}
	}
	
	

	@MethodLog(description = "资源删除")
	@Perm(privilegeValue = "delete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer resId, Integer type) {
		if (!ValidateUtil.isEmpty(resId)) {
			switch (type){
			case 10 :{
				try {
					resSquareService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 1 :{
				try {
					resSchoolService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 2 :{
				try {
					resBazaarService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 3 :{
				try {
					resSupermarketService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 4 :{
				try {
					resHospitalService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 5 :{
				try {
					resReservoirService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 6 :{
				try {
					resUptownService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 7 :{
				try {
					resCompanyService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 8 :{
				try {
					resBusstationService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			case 9 :{
				try {
					resEntertainmentService.delete(resId);
					return json(true, "删除成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("删除失败");
				}
			}
			}
		}
		return null;
	}
	
	
	@RequestMapping("/square")
	public String square(Integer page, String query, ResSquareVo resSquareVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Square> pageView = new PageView<R_Res_Square>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resSquareVo.getSq_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.sq_Name like ?").append((params.size() + 1));
				params.add("%" + resSquareVo.getSq_Name().trim() + "%");
			}
		}
		model.addAttribute("resSquareVo", resSquareVo);
		pageView.setQueryResult(resSquareService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/square_list";
	}
	
	@RequestMapping("/school")
	public String school(Integer page, String query, ResSchoolVo resSchoolVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_School> pageView = new PageView<R_Res_School>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resSchoolVo.getSc_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.sc_Name like ?").append((params.size() + 1));
				params.add("%" + resSchoolVo.getSc_Name().trim() + "%");
			}
		}
		model.addAttribute("resSchoolVo", resSchoolVo);
		pageView.setQueryResult(resSchoolService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/school_list";
	}
	
	@RequestMapping("/bazaar")
	public String bazaar(Integer page, String query, ResBazaarVo resBazaarVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Bazaar> pageView = new PageView<R_Res_Bazaar>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resBazaarVo.getBa_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.ba_Name like ?").append((params.size() + 1));
				params.add("%" + resBazaarVo.getBa_Name().trim() + "%");
			}
		}
		model.addAttribute("resBazaarVo", resBazaarVo);
		pageView.setQueryResult(resBazaarService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/bazaar_list";
	}
	
	@RequestMapping("/supermarket")
	public String supermarket(Integer page, String query, ResSupermarketVo resSupermarketVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Supermarket> pageView = new PageView<R_Res_Supermarket>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resSupermarketVo.getSu_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.su_Name like ?").append((params.size() + 1));
				params.add("%" + resSupermarketVo.getSu_Name().trim() + "%");
			}
		}
		model.addAttribute("resSupermarketVo", resSupermarketVo);
		pageView.setQueryResult(resSupermarketService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/supermarket_list";
	}
	
	@RequestMapping("/hospital")
	public String hospital(Integer page, String query, ResHospitalVo resHospitalVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Hospital> pageView = new PageView<R_Res_Hospital>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resHospitalVo.getHo_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.ho_Name like ?").append((params.size() + 1));
				params.add("%" + resHospitalVo.getHo_Name().trim() + "%");
			}
		}
		model.addAttribute("resHospitalVo", resHospitalVo);
		pageView.setQueryResult(resHospitalService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/hospital_list";
	}
	
	@RequestMapping("/reservoir")
	public String reservoir(Integer page, String query, ResReservoirVo resReservoirVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Reservoir> pageView = new PageView<R_Res_Reservoir>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resReservoirVo.getRe_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.re_Name like ?").append((params.size() + 1));
				params.add("%" + resReservoirVo.getRe_Name().trim() + "%");
			}
		}
		model.addAttribute("resReservoirVo", resReservoirVo);
		pageView.setQueryResult(resReservoirService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/reservoir_list";
	}
	
	@RequestMapping("/uptown")
	public String uptown(Integer page, String query, ResUptownVo resUptownVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Uptown> pageView = new PageView<R_Res_Uptown>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resUptownVo.getUp_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.up_Name like ?").append((params.size() + 1));
				params.add("%" + resUptownVo.getUp_Name().trim() + "%");
			}
		}
		model.addAttribute("resUptownVo", resUptownVo);
		pageView.setQueryResult(resUptownService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/uptown_list";
	}
	
	@RequestMapping("/company")
	public String company(Integer page, String query, ResCompanyVo resCompanyVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Company> pageView = new PageView<R_Res_Company>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resCompanyVo.getCo_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.co_Name like ?").append((params.size() + 1));
				params.add("%" + resCompanyVo.getCo_Name().trim() + "%");
			}
		}
		model.addAttribute("resCompanyVo", resCompanyVo);
		pageView.setQueryResult(resCompanyService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/company_list";
	}
	
	@RequestMapping("/entertainment")
	public String entertainment(Integer page, String query, ResEntertainmentVo resEntertainmentVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Entertainment> pageView = new PageView<R_Res_Entertainment>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resEntertainmentVo.getEn_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.en_Name like ?").append((params.size() + 1));
				params.add("%" + resEntertainmentVo.getEn_Name().trim() + "%");
			}
		}
		model.addAttribute("resEntertainmentVo", resEntertainmentVo);
		pageView.setQueryResult(resEntertainmentService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/entertainment_list";
	}
	
	@RequestMapping("/busstation")
	public String busstation(Integer page, String query, ResBusstationVo resBusstationVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Res_Busstation> pageView = new PageView<R_Res_Busstation>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(resBusstationVo.getBu_Name())) {
				if (params.size()>0)
				jpql.append(" and ");
				jpql.append(" o.bu_Name like ?").append((params.size() + 1));
				params.add("%" + resBusstationVo.getBu_Name().trim() + "%");
			}
		}
		model.addAttribute("resBusstationVo", resBusstationVo);
		pageView.setQueryResult(resBusstationService.getScrollList(
				pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		return "jsp/resource/assets/busstation_list";
	}
	
	@RequestMapping("/squareExcelOut")
	public String squareExcelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Res_Square> list = resSquareService.getListEntitys();
			
			sheet.openCell("A4").setValue("名称");
			sheet.openCell("B4").setValue("联系人");
			sheet.openCell("C4").setValue("联系人电话");
			sheet.openCell("D4").setValue("地址");
			sheet.openCell("E4").setValue("所属单位");
				
			int i=5;
			for(R_Res_Square element:list){
					    sheet.openCell("A"+i).setValue(element.getSq_Name()+"");
						sheet.openCell("B"+i).setValue(element.getSq_Linkman()+"");
						sheet.openCell("C"+i).setValue(element.getSq_Linkmantel()+"");
						sheet.openCell("D"+i).setValue(element.getSq_Address()+"");
						sheet.openCell("E"+i).setValue(element.getSq_Dept()+"");
						i++;
			}
			model.addAttribute("wb",wb);
			return "jsp/poffice/resreport";
	}
	
	@RequestMapping("/schoolExcelOut")
	public String schoolExcelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Res_School> list = resSchoolService.getListEntitys();
			
			sheet.openCell("A4").setValue("名称");
			sheet.openCell("B4").setValue("联系人");
			sheet.openCell("C4").setValue("联系人电话");
			sheet.openCell("D4").setValue("地址");
				
			int i=5;
			for(R_Res_School element:list){
					    sheet.openCell("A"+i).setValue(element.getSc_Name()+"");
						sheet.openCell("B"+i).setValue(element.getSc_Linkman()+"");
						sheet.openCell("C"+i).setValue(element.getSc_Linkmantel()+"");
						sheet.openCell("D"+i).setValue(element.getSc_Address()+"");
						i++;
			}
			model.addAttribute("wb",wb);
			return "jsp/poffice/resreport";
	}
	
	@RequestMapping("/reservoirExcelOut")
	public String reservoirExcelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Res_Reservoir> list = resReservoirService.getListEntitys();
			
			sheet.openCell("A4").setValue("名称");
			sheet.openCell("B4").setValue("面积");
			sheet.openCell("C4").setValue("储水量");
			sheet.openCell("D4").setValue("地址");
			sheet.openCell("E4").setValue("联系人");
			sheet.openCell("F4").setValue("联系人电话");
				
			int i=5;
			for(R_Res_Reservoir element:list){
					    sheet.openCell("A"+i).setValue(element.getRe_Name()+"");
					    sheet.openCell("B"+i).setValue(element.getRe_Area()+"");
					    sheet.openCell("C"+i).setValue(element.getRe_Capacity()+"");
					    sheet.openCell("D"+i).setValue(element.getRe_Address()+"");
						sheet.openCell("E"+i).setValue(element.getRe_Linkman()+"");
						sheet.openCell("F"+i).setValue(element.getRe_Linkmantel()+"");
						i++;
			}
			model.addAttribute("wb",wb);
			return "jsp/poffice/resreport";
	}
	
	@RequestMapping("excelin")
	@ResponseBody
	public Json excelin(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file)
			throws IOException {
		
		MultipartHttpServletRequest re = (MultipartHttpServletRequest) request;
		MultipartFile fileM = re.getFile("file");
		CommonsMultipartFile cf = (CommonsMultipartFile) fileM;
		InputStream inputStream = cf.getInputStream();

		Workbook wookbook = null;
		try {
			// 2003版本的excel，用.xls结尾
			wookbook = new HSSFWorkbook(inputStream);// 得到工作簿
		} catch (Exception ex) {
			// ex.printStackTrace();
			try {
				// 2007版本的excel，用.xlsx结尾
				wookbook = new XSSFWorkbook(inputStream);// 得到工作簿
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 得到一个工作表
		Sheet sheet = wookbook.getSheetAt(0);
		// 获得表头
		Row rowHead = sheet.getRow(0);
		// 判断表头是否正确
		if (rowHead.getPhysicalNumberOfCells() != 5) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String type = "";
				String man = "";
				String mantel = "";
				String address = "";
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			Row row = sheet.getRow(i);

			Cell as_name = row.getCell((short) 0);
			if (as_name != null) {
				name = as_name.getStringCellValue().toString();
			}

			Cell as_man = row.getCell((short) 2);
			if (as_man != null) {
				man = as_man.getStringCellValue().toString();
			}

			Cell as_mantel = row.getCell((short) 3);
			if (as_mantel != null) {
				as_mantel.setCellType(Cell.CELL_TYPE_STRING);
				mantel = as_mantel.getStringCellValue().toString();
			}

			Cell as_address = row.getCell((short) 4);
			if (as_address != null) {
				address = as_address.getStringCellValue().toString();
			}

			Cell as_type = row.getCell((short) 1);
			if (as_type == null) {
				response.getWriter().write("第  " +i+ " 行错误,类型不能为空 ,请检查数据");
				return null;
			}
			try {

				type = as_type.getStringCellValue().toString();
				if (type.equals("广场")) {
					R_Res_Square square = new R_Res_Square();
					square.setSq_Name(name);
					square.setSq_Linkman(man);
					square.setSq_Linkmantel(mantel);
					square.setSq_Address(address);
					resSquareService.save(square);
				}
				if (type.equals("学校")) {
					R_Res_School school = new R_Res_School();
					school.setSc_Name(name);
					school.setSc_Linkman(man);
					school.setSc_Linkmantel(mantel);
					school.setSc_Address(address);
					resSchoolService.save(school);
				}
				if (type.equals("市场")) {
					R_Res_Supermarket market = new R_Res_Supermarket();
					market.setSu_Name(name);
					market.setSu_Linkman(man);
					market.setSu_Linkmantel(mantel);
					market.setSu_Address(address);
					resSupermarketService.save(market);
				}
				if (type.equals("商场")) {
					R_Res_Bazaar bazaar = new R_Res_Bazaar();
					bazaar.setBa_Name(name);
					bazaar.setBa_Linkman(man);
					bazaar.setBa_Linkmantel(mantel);
					bazaar.setBa_Address(address);
					resBazaarService.save(bazaar);
				}
				if (type.equals("医院")) {
					R_Res_Hospital hospital = new R_Res_Hospital();
					hospital.setHo_Name(name);
					hospital.setHo_Linkman(man);
					hospital.setHo_Linkmantel(mantel);
					hospital.setHo_Address(address);
					resHospitalService.save(hospital);
				}
				if (type.equals("水库")) {
					R_Res_Reservoir reservoir = new R_Res_Reservoir();
					reservoir.setRe_Name(name);
					reservoir.setRe_Linkman(man);
					reservoir.setRe_Linkmantel(mantel);
					reservoir.setRe_Address(address);
					resReservoirService.save(reservoir);
				}
				if (type.equals("社区")) {
					R_Res_Uptown uptown = new R_Res_Uptown();
					uptown.setUp_Name(name);
					uptown.setUp_Linkman(man);
					uptown.setUp_Linkmantel(mantel);
					uptown.setUp_Address(address);
					resUptownService.save(uptown);
				}
				if (type.equals("企业")) {
					R_Res_Company company = new R_Res_Company();
					company.setCo_Name(name);
					company.setCo_Linkman(man);
					company.setCo_Linkmantel(mantel);
					company.setCo_Address(address);
					resCompanyService.save(company);
				}
				if (type.equals("汽车站")) {
					R_Res_Busstation busstation = new R_Res_Busstation();
					busstation.setBu_Name(name);
					busstation.setBu_Linkman(man);
					busstation.setBu_Linkmantel(mantel);
					busstation.setBu_Address(address);
					resBusstationService.save(busstation);
				}
				if (type.equals("娱乐场所")) {
					R_Res_Entertainment ent = new R_Res_Entertainment();
					ent.setEn_Name(name);
					ent.setEn_Linkman(man);
					ent.setEn_Linkmantel(mantel);
					ent.setEn_Address(address);
					resEntertainmentService.save(ent);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("第  " +i+ " 行错误,请检查数据");
				return null;
			}
		}
		response.getWriter().write("导入成功");
		return null;
	}

}
