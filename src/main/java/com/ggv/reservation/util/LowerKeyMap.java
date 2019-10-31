package com.ggv.reservation.util;


import org.apache.commons.collections4.map.ListOrderedMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

@Alias("myMap") @Component
public class LowerKeyMap extends ListOrderedMap<String, Object>{
    /** serialVersionUID */
 
    /**
     * key 에 대하여 소문자로 변환하여 super.put
     * (ListOrderedMap) 을 호출한다.
     * @param key
     *        - '_' 가 포함된 변수명
     * @param value
     *        - 명시된 key 에 대한 값 (변경 없음)
     * @return previous value associated with specified
     *         key, or null if there was no mapping for
     *         key
     */
    public Object put(String key, Object value) {
        return super.put(StringUtils.lowerCase((String) key), value);
    }
}