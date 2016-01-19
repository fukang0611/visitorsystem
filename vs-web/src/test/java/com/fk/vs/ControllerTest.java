package com.fk.vs;

import com.fk.core.controller.RecordController;
import com.fk.core.controller.VisitorController;
import com.fk.core.utils.Pager;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration(value = "src/main/webapp")
@ContextHierarchy({
        @ContextConfiguration(name = "parent", locations = "classpath:spring.xml"),
        @ContextConfiguration(name = "child", locations = "classpath:spring-mvc.xml")
})
public class ControllerTest {

    @Autowired
    private WebApplicationContext wac;
    @Autowired
    private RecordController recordController;
    private MockMvc mockMvc;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    @Before
    public void setUp() {
        // mockMvc = MockMvcBuilders.standaloneSetup(recordController).build(); // 独立测试,直接调用controller方法
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build(); // 在web环境下测试,通过请求url
        request = new MockHttpServletRequest();
        request.setCharacterEncoding("UTF-8");
        response = new MockHttpServletResponse();
    }

    @Test
    public void testAddVisitor() throws Exception {

        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.put("/staff/editStaff.do?id='1'"))
/*                .andExpect(MockMvcResultMatchers.view().name("user/view"))
                .andExpect(MockMvcResultMatchers.model().attributeExists("user"))*/
                .andDo(MockMvcResultHandlers.print())
                .andReturn();

//        Assert.assertNotNull(result.getModelAndView().getModel().get("user"));
    }

    @Test
    public void testAddRecord() throws Exception {

        try {
            String id = "41010319920611011X";
            String staffID = "4028b881520acd2a01520b02780c0000";
            Assert.assertEquals("success", recordController.add(id, staffID));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testTodayVisit() throws Exception {

        Pager pager = new Pager(null, null, "asc", 10, 0, null);
        mockMvc.perform(MockMvcRequestBuilders.post("/record/today.do").characterEncoding("UTF-8")
                .param("order", pager.getOrder())
                .param("limit", pager.getLimit().toString())
                .param("offset", pager.getOffset().toString()))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andDo(MockMvcResultHandlers.print())
                .andReturn();
    }
}
