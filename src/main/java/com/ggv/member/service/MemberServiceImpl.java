package com.ggv.member.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;
import com.ggv.member.mapper.MemberMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	@Setter
	@Autowired
	private MemberMapper mapper;
	@Setter @Autowired
	private JavaMailSenderImpl mailSender;
	
	@Override
	public List<MemberVO> getMemberList() {
		// TODO Auto-generated method stub
		return mapper.getMemberList();
	}

	@Override
	public MemberVO getMember(MemberVO member) {
		// TODO Auto-generated method stub
		return mapper.getMember(member);
	}

	@Override
	public int getCountMember(String userid) {
		// TODO Auto-generated method stub
		return mapper.getCountMember(userid);
	}
	
	@Override
	public int getCountMemberByEmail(String email) {
		// TODO Auto-generated method stub
		return mapper.getCountMemberByEmail(email);
	}

	@Override
	public void addMember(MemberVO member) {
		// TODO Auto-generated method stub
		mapper.addMember(member);
	}

	@Override
	public void modifyMember(MemberVO member) {
		// TODO Auto-generated method stub
		mapper.modifyMember(member);
	}

	@Override
	public void removeMember(MemberVO member) {
		// TODO Auto-generated method stub
		mapper.removeMember(member);
	}

	@Override
	public MemberVO getUserByNameEmail(MemberVO member, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		MemberVO getMember = mapper.getUserByNameEmail(member);
		if(getMember == null) {
			return null;
		} else {
			sendEmail(getMember, "userid");
			return getMember;
		}
	}
	
	@Override
	public MemberVO getUserByUseridEmail(MemberVO member, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		MemberVO getMember = mapper.getUserByUseridEmail(member);
		if(getMember == null) {
			return null;
		} else {
			sendEmail(getMember, "password");
			return getMember;
		}
	}
	
	@Override
	public void modifyMemberPassword(MemberVO member) {
		// TODO Auto-generated method stub
		mapper.modifyMemberPassword(member);
	}
	
	@Override
	public void sendEmail(MemberVO member, String cat) {
		// TODO Auto-generated method stub
		SimpleMailMessage message = new SimpleMailMessage();
		// 보내는 주소를 바꿀 수 있으면 좋은데
		// 아직 방법을 모르겠다.
		message.setFrom("ggv.noreply@gmail.com");
		message.setTo(member.getEmail());
		String str = "";
		
		if(cat.equals("userid")) {
			message.setSubject("<GGV> 요청하신 아이디 정보입니다.");
			str += "요청하신 계정 정보는 아래와 같습니다.\n";
			str += "-------------------------------------\n";
			str += "아이디 : " + member.getUserid() +"\n";
			str += "이메일 주소 : " + member.getEmail() + "\n";
			str += "-------------------------------------\n";
			str += "이 메일은 회신이 불가능합니다.\n";
			str += "-------------------------------------\n";
			message.setText(str);
		} else if(cat.equals("password")) {
			String tempPassword = "";
			for (int i = 0; i < 6; i++) {
				tempPassword += (char) ((Math.random() * 26) + 97);
			}
			message.setSubject("<GGV> 요청하신 비밀번호 정보입니다.");
			str += "요청하신 계정 정보는 아래와 같습니다.\n";
			str += "-------------------------------------\n";
			str += "아이디 : " + member.getUserid() + "\n";
			str += "이메일 주소 : " + member.getEmail() + "\n";
			str += "임시 비밀번호 : " + tempPassword + "\n";
			str += "-------------------------------------\n";
			str += "기존 비밀번호는 더이상 사용 불가능 합니다.\n";
			str += "임시 비밀번호를 통해 로그인 하신 뒤\n";
			str += "비밀번호를 변경해 주세요.\n";
			str += "-------------------------------------\n";
			str += "이 메일은 회신이 불가능합니다.\n";
			str += "-------------------------------------\n";
			message.setText(str);
			modifyMemberPassword(new MemberVO(member.getUserid(), MemberSha256.encrypt(tempPassword)));
		}
		
		mailSender.send(message);
	}
	
	
	
	@Override
	public void addAlertScript(String str, HttpServletResponse resp) {
		try {
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('"+str+"');");
			out.println("history.back(-1);");
			out.println("</script>");
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String getAccessTokenKakao(String authorizecode) {
		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=5de415f69c80956aabe62e730552ebd4");
            sb.append("&redirect_uri=https://ggv.min0s.com/user/kakao");
            sb.append("&code=" + authorizecode);
            bw.write(sb.toString());
            bw.flush();
            
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
	}

	@Override
	public HashMap<String, Object> getUserInfoByKakao(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        //    요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("response body : " + result);
	        
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        
	        System.out.println(kakao_account);
	        
	        String name = properties.getAsJsonObject().get("nickname").getAsString();
	        
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        //String birthday = kakao_account.getAsJsonObject().get("birthday").getAsString();
	        
	        userInfo.put("name", name);
	        userInfo.put("email", email);
	        //userInfo.put("birthday", birthday);
	        
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	    
	    return userInfo;
	}

	@Override
	public KakaoMemberVO getKakaoMember(String userid) {
		// TODO Auto-generated method stub
		return mapper.getKakaoMember(userid);
	}

	@Override
	public void modifyKakaoMember(KakaoMemberVO kakaoMember) {
		// TODO Auto-generated method stub
		mapper.modifyKakaoMember(kakaoMember);
	}

	@Override
	public void addKakaoMember(KakaoMemberVO kakaoMember) {
		// TODO Auto-generated method stub
		mapper.addKakaoMember(kakaoMember);
	}
}
