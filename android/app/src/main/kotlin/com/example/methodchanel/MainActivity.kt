package com.example.methodchanel

import android.annotation.TargetApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import java.time.LocalDate
import java.time.chrono.HijrahDate
import java.time.format.DateTimeFormatter

class MainActivity: FlutterActivity() {
    private val CONVERT_CHANEL="omarChanelName";
    private  lateinit var channel: MethodChannel
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel= MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CONVERT_CHANEL)
        //receive data from flutterSÍ
        channel.setMethodCallHandler{call,result->
            if (call.method=="convertToHijri"){
                val  arguments= call.arguments() as Map<String,String>?
                val hijriDate=arguments!!["hijriDate"]
                val hijriiDate= if (VERSION.SDK_INT >= VERSION_CODES.O) {
                    getHijriDate(hijriDate.toString())
                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                result.success(hijriiDate)
            }else{
                result.notImplemented()
            }
        }
    }

    @TargetApi(VERSION_CODES.O)
    private  fun getHijriDate(hijDate:String):Map<String,String>{
        val isldamicDate:HijrahDate
        val gregorianDate:LocalDate
        gregorianDate = LocalDate.parse(hijDate,  DateTimeFormatter.ofPattern("d/M/yyyy"));
        isldamicDate = HijrahDate.from(gregorianDate);
        println(isldamicDate)
        val mmap= mapOf("datee" to isldamicDate.toString())
        return  mmap
    }
}
