package com.sshs.security.configuration;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.FormLoginConfigurer;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.util.StringUtils;

import com.sshs.security.auth.SshsAuthenticationProvider;
import com.sshs.security.filter.SshsFilterSecurityInterceptor;
import com.sshs.security.handle.LoginSuccessHandler;

/**
 * Created by Administrator on 2017/3/8.
 */
@Configuration
@SuppressWarnings("all")
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	//@Resource
	//private SecurityUserServiceImpl securityUserService;
	//@Resource
	//private SecurityMetadataSource securityMetadataSource;
	// @Resource
	// private SshsAccessDecisionManager sshsAccessDecisionManager;
	@Resource
	 private SshsFilterSecurityInterceptor sshsFilterSecurityInterceptor;
	@Resource
	private SshsAuthenticationProvider sshsAuthenticationProvider;// 自定义验证
	@Value("${login.loginPage:}")
	private String loginPage;
	@Value("${login.loginProcessing:/login}")
	private String loginProcessing;
	@Autowired
	SessionRegistry sessionRegistry;
	@Autowired
	LoginSuccessHandler loginSuccessHandler;
	/*
	 * @Override protected void configure(AuthenticationManagerBuilder auth) throws
	 * Exception { //
	 * auth.inMemoryAuthentication().withUser("root").password("root").authorities(
	 * "USER") // .and().withUser("green").password("green").authorities("USER",
	 * "ADMIN"); // 自定义认证 auth.authenticationProvider(authenticationProvider()); }
	 */

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		if (StringUtils.isEmpty(loginPage)) {
			http.csrf().disable().authorizeRequests().anyRequest().authenticated().and().formLogin().and().httpBasic();
		} else {
			FormLoginConfigurer<HttpSecurity> fl = http
					.csrf().disable().authorizeRequests().antMatchers("/login*", "/css/**", "/js/**", "/scripts/**",
							"/images/**", "/img/**", "/webjars/**", "**/favicon.ico", "/index")
					.permitAll().anyRequest().authenticated().and().formLogin();
			if (!StringUtils.isEmpty(loginPage)) {
				fl = fl.loginPage(loginPage).loginProcessingUrl(loginProcessing).successHandler(loginSuccessHandler);
				/*
				 * if (!StringUtils.isEmpty(mainPage)) { fl = fl.defaultSuccessUrl(mainPage); }
				 */
			}
			fl.permitAll().and().httpBasic();
		}
		http.addFilterBefore(sshsFilterSecurityInterceptor, FilterSecurityInterceptor.class);
	}

	/*@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		// 这里是新增一个默认用户
		auth.inMemoryAuthentication().withUser("admin").password("password").roles("ADMIN");
	}*/

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// 将验证过程交给自定义验证工具
		auth.authenticationProvider(sshsAuthenticationProvider);
	}

	@Bean
	public SessionRegistry getSessionRegistry() {
		SessionRegistry sessionRegistry = new SessionRegistryImpl();
		return sessionRegistry;
	}

	/**
	 * csrf过滤拦截器
	 */
	/*
	 * @Bean public FilterRegistrationBean csrfFilterRegistrationBean() {
	 * FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
	 * filterRegistrationBean.setFilter(new CsrfFilter());
	 * filterRegistrationBean.setOrder(2); filterRegistrationBean.setEnabled(true);
	 * filterRegistrationBean.addUrlPatterns("/*"); Map<String, String>
	 * initParameters = new HashMap(); initParameters.put("excludes", "/login/*");
	 * initParameters.put("isOpen", "true");
	 * filterRegistrationBean.setInitParameters(initParameters); return
	 * filterRegistrationBean; }
	 */
}
