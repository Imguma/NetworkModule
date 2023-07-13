//
//  ConstantsResponse.swift
//  NetworkModule
//
//  Created by 애니모비 on 2023/07/13.
//

import Foundation

public enum NetworkResponse {
    // response
    public static let JSON_KEY_RESPONSE = "response"
    public static let JSON_KEY_ACTION_RESULT = "action_result"
    public static let JSON_KEY_ACTION_FAILURE_REASON = "action_failure_reason"
    public static let JSON_KEY_ACTION_FAILURE_CODE = "action_failure_code"
    public static let JSON_KEY_ACTION_SUCCESS_MESSAGE = "action_success_message"
    
    // action result value
    public static let JSON_VALUE_SUCCESS = "success"
    public static let JSON_VALUE_FAILURE = "failure"
    
    // content
    public static let JSON_KEY_CONTENT = "content"
    public static let JSON_KEY_FRAME_INFO = "frame_info"
    public static let JSON_KEY_ARGUMENT = "argument"
    public static let JSON_KEY_BOUNCE_EFFECT = "bounce_effect"
    public static let JSON_KEY_JS_RIGHT = "js_right"
    public static let JSON_KEY_HTML_URL = "html_url"
    public static let JSON_KEY_JS_LEFT = "js_left"
    public static let JSON_KEY_TITLE = "title"
    public static let JSON_KEY_BTN_LEFT = "btn_left"
    public static let JSON_KEY_BTN_RIGHT = "btn_right"
    public static let JSON_KEY_JS_ON_RESUME = "js_on_resume"
    public static let JSON_KEY_MOTION_CLOSE = "motion_close"
    public static let JSON_KEY_RELOAD_ON_RESUME = "reload_on_resume"
    public static let JSON_KEY_TEMPLATE = "template"
    public static let JSON_KEY_FRAME_TYPE = "frame_type"
    
    // content - sns_info
    public static let JSON_KEY_SNS_INFO = "sns_info"
    public static let JSON_KEY_KAKAO_APP_KEY = "kakao_app_key"
    public static let JSON_KEY_NAVER_CLIENT_ID = "naver_client_id"
    public static let JSON_KEY_NAVER_CLIENT_SECRET = "naver_client_secret"
    
    // content - app_update_info
    public static let JSON_KEY_APP_UPDATE_INFO = "app_update_info"
    public static let JSON_KEY_APP_UPDATE_STATUS = "app_update_status"
    public static let JSON_KEY_VERSION_INFO_XML_URL = "version_info_xml_url"
}
