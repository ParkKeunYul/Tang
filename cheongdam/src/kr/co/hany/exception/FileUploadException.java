package kr.co.hany.exception;

public class FileUploadException extends Exception{
	String errCode = null;
	String errMsg = null;

	public FileUploadException() {
		super();
	}

	public FileUploadException(String errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}

	public String getErrCode() {
		return errCode;
	}

	public String getErrMsg() {
		return errMsg;
	}
}
