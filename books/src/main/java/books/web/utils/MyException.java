package books.web.utils;


/**
 * self define exception
 */
public class MyException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String message;

	
	
	public MyException(String message) {
		super();
		this.message = message;
	}

	
	
	public MyException() {
		super();
	}



	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
	
}
