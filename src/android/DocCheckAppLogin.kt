package doccheck.cordova

import android.content.Intent
import com.doccheck.apploginsdk.DocCheckLoginActivity
import org.apache.cordova.*
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

class DocCheckAppLogin: CordovaPlugin() {
  private lateinit var context: CallbackContext
  private val REQUEST_CODE = 2022;

  @Throws(JSONException::class)
  override fun execute(action: String, data: JSONArray, callbackContext: CallbackContext): Boolean {
    context = callbackContext

    var result = true
    if (action != "openLogin") {
      return result
    }

    try {
      val loginId = data.getString(0)
      val language = data.optString(1)
      val templateName = data.getString(2)
      val intent = Intent(cordova.activity.applicationContext, DocCheckLoginActivity::class.java).apply {
        putExtra("loginId", loginId)
        putExtra("language", if (language == "null") "de" else language)
        putExtra("templateName", if (templateName == "null") "s_mobile" else templateName)
      }

      cordova.startActivityForResult(this, intent, REQUEST_CODE)
    } catch (e: Exception) {
      val result = JSONObject()
      result.put("success","0")
      result.put("message","login failed to open, make sure to provide a loginId.")
      context.error(result)
    }
    result = false
    return result

  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    if (requestCode != REQUEST_CODE) {
      return
    }

    val result = JSONObject()
    if (data == null) {
      result.put("success","0")
      context.error(result)
      return
    }
    val loginResult: Boolean = data.getBooleanExtra("LOGIN_RESULT", false)
    val loginResponse: String = data.getStringExtra("RESPONSE") ?: "ERROR"
    result.put("success",if (loginResult) "1" else "0")
    when(loginResponse) {
      "ERROR" -> {
        result.put("message","login failed")
        context.error(result)
      }
      "CANCEL" -> {
        result.put("message","user canceled the login")
        context.error(result)
      }
      "SUCCEEDED" -> {
        val map = data.getSerializableExtra("URLPARAMS") as? Map<String, List<String>?>
        val resultData = JSONObject()
        map?.forEach{ (key, value) ->
          if (value?.size == 1) {
            resultData.put(key, value[0])
          }
          else {
            resultData.put(key, value)
          }
        }
        result.put("data", resultData)
        context.success(result)
      }
    }
  }
}
