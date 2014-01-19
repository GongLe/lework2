package org.lework.runner.web;

import org.junit.Test;
import org.lework.runner.mapper.JsonMapper;
import org.lework.runner.web.vo.HttpStatus;
import org.lework.runner.web.vo.JsonResult;

public class JsonResultTest {


    @Test
    public void toJson() {
        JsonResult failure = JsonResult.failure("bad").setHttpStatus(HttpStatus.BAD_REQUEST);
        JsonResult success = JsonResult.success("success").setHttpStatus(HttpStatus.OK);
        System.out.println((new JsonMapper()).toJson(failure));
        System.out.println((new JsonMapper()).toJson(success));
    }


}
