class apiError extends Error{
    constructor(status,message="Something Went Wrong",error=[],stack=""){
        super(message);
        this.status=status
        this.message=message
        this.data=null
        this.error=error
        this.success=false
        if(!stack){
            this.stack=stack
        }else{
            Error.captureStackTrace(this,this.constructor)
        }
    }
}
export {apiError}