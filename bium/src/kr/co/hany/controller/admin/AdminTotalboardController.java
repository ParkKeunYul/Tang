package kr.co.hany.controller.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hany.common.BoardUtil;
import kr.co.hany.common.Const;
import kr.co.hany.util.MsgUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.ParamUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.util.FileUpload;
import kr.co.hany.util.FileUploadUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping ("/admin/totalboard/*")
public class AdminTotalboardController extends AdminDefaultController{

	
}
