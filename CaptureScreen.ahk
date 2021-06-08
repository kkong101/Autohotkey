

CoordMode,Mouse,Client
CoordMode,Pixel,Client

global MAX_CHAR_NUM := 4  ; 총 캐릭터 갯수 
global MAX_ID_NUM := 4    ; 아이디 총 갯수 
global CHANGING_CHAR_NUM := 5 ; 몇번 반복일때 캐릭터 바꿀지 
;~ global CHANGING_ID_NUM := 40 ; 몇번 반복일때 아이디 바꿀지 


global current_char_num := 0
global current_id_num := 1 ;금속촉매일때 1, 부캐일때 2 
global ifPenghi := 0


global x_Array :=[] 
global y_Array :=[]

global file_name
global file_number ; 파일 시작 번호 설정 
global chartimerNum
global idtimerNum

global MaxIdNum := 2
global yamanNum := 0
global hap := 0
global errorTime := 0
global dailyNum := 0
global novice := 0


/* CaptureScreen(aRect, bCursor, sFileTo, nQuality)
1) If the optional parameter bCursor is True, captures the cursor too.
2) If the optional parameter sFileTo is 0, set the image to Clipboard.
   If it is omitted or "", saves to screen.bmp in the script folder,
   otherwise to sFileTo which can be BMP/JPG/PNG/GIF/TIF.
3) The optional parameter nQuality is applicable only when sFileTo is JPG. Set it to the desired quality level of the resulting JPG, an integer between 0 - 100.
4) If aRect is 0/1/2/3, captures the entire desktop/active window/active client area/active monitor.
5) aRect can be comma delimited sequence of coordinates, e.g., "Left, Top, Right, Bottom" or "Left, Top, Right, Bottom, Width_Zoomed, Height_Zoomed".
   In this case, only that portion of the rectangle will be captured. Additionally, in the latter case, zoomed to the new width/height, Width_Zoomed/Height_Zoomed.

Example:
CaptureScreen(0)
CaptureScreen(1)
CaptureScreen(2)
CaptureScreen(3)
CaptureScreen("100, 100, 200, 200")
CaptureScreen("100, 100, 200, 200, 400, 400")   ; Zoomed
*/

/* Convert(sFileFr, sFileTo, nQuality)
Convert("C:\image.bmp", "C:\image.jpg")
Convert("C:\image.bmp", "C:\image.jpg", 95)
Convert(0, "C:\clip.png")   ; Save the bitmap in the clipboard to sFileTo if sFileFr is "" or 0.
*/

CaptureScreen(aRect = 0, bCursor = False, sFile = "", nQuality = "")
{
    If !aRect
    {
        SysGet, nL, 76  ; virtual screen left & top
        SysGet, nT, 77
        SysGet, nW, 78    ; virtual screen width and height
        SysGet, nH, 79
    }
    Else If aRect = 1
        WinGetPos, nL, nT, nW, nH, A
    Else If aRect = 2
    {
        WinGet, hWnd, ID, A
        VarSetCapacity(rt, 16, 0)
        DllCall("GetClientRect" , "ptr", hWnd, "ptr", &rt)
        DllCall("ClientToScreen", "ptr", hWnd, "ptr", &rt)
        nL := NumGet(rt, 0, "int")
        nT := NumGet(rt, 4, "int")
        nW := NumGet(rt, 8)
        nH := NumGet(rt,12)
    }
    Else If aRect = 3
    {
        VarSetCapacity(mi, 40, 0)
        DllCall("GetCursorPos", "int64P", pt), NumPut(40,mi,0,"uint")
        DllCall("GetMonitorInfo", "ptr", DllCall("MonitorFromPoint", "int64", pt, "Uint", 2, "ptr"), "ptr", &mi)
        nL := NumGet(mi, 4, "int")
        nT := NumGet(mi, 8, "int")
        nW := NumGet(mi,12, "int") - nL
        nH := NumGet(mi,16, "int") - nT
    }
    Else
    {
        StringSplit, rt, aRect, `,, %A_Space%%A_Tab%
        nL := rt1    ; convert the Left,top, right, bottom into left, top, width, height
        nT := rt2
        nW := rt3 - rt1
        nH := rt4 - rt2
        znW := rt5
        znH := rt6
    }

    mDC := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    hBM := CreateDIBSection(mDC, nW, nH)
    oBM := DllCall("SelectObject", "ptr", mDC, "ptr", hBM, "ptr")
    hDC := DllCall("GetDC", "ptr", 0, "ptr")
    DllCall("BitBlt", "ptr", mDC, "int", 0, "int", 0, "int", nW, "int", nH, "ptr", hDC, "int", nL, "int", nT, "Uint", 0x40CC0020)
    DllCall("ReleaseDC", "ptr", 0, "ptr", hDC)
    If bCursor
        CaptureCursor(mDC, nL, nT)
    DllCall("SelectObject", "ptr", mDC, "ptr", oBM)
    DllCall("DeleteDC", "ptr", mDC)
    If znW && znH
        hBM := Zoomer(hBM, nW, nH, znW, znH)
    If sFile = 0
        SetClipboardData(hBM)
    Else Convert(hBM, sFile, nQuality), DllCall("DeleteObject", "ptr", hBM)
}

CaptureCursor(hDC, nL, nT)
{
    VarSetCapacity(mi, 32, 0), Numput(16+A_PtrSize, mi, 0, "uint")
    DllCall("GetCursorInfo", "ptr", &mi)
    bShow   := NumGet(mi, 4, "uint")
    hCursor := NumGet(mi, 8)
    xCursor := NumGet(mi,8+A_PtrSize, "int")
    yCursor := NumGet(mi,12+A_PtrSize, "int")

    DllCall("GetIconInfo", "ptr", hCursor, "ptr", &mi)
    xHotspot := NumGet(mi, 4, "uint")
    yHotspot := NumGet(mi, 8, "uint")
    hBMMask  := NumGet(mi,8+A_PtrSize)
    hBMColor := NumGet(mi,16+A_PtrSize)

    If bShow
        DllCall("DrawIcon", "ptr", hDC, "int", xCursor - xHotspot - nL, "int", yCursor - yHotspot - nT, "ptr", hCursor)
    If hBMMask
        DllCall("DeleteObject", "ptr", hBMMask)
    If hBMColor
        DllCall("DeleteObject", "ptr", hBMColor)
}

Zoomer(hBM, nW, nH, znW, znH)
{
    mDC1 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    mDC2 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    zhBM := CreateDIBSection(mDC2, znW, znH)
    oBM1 := DllCall("SelectObject", "ptr", mDC1, "ptr",  hBM, "ptr")
    oBM2 := DllCall("SelectObject", "ptr", mDC2, "ptr", zhBM, "ptr")
    DllCall("SetStretchBltMode", "ptr", mDC2, "int", 4)
    DllCall("StretchBlt", "ptr", mDC2, "int", 0, "int", 0, "int", znW, "int", znH, "ptr", mDC1, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", 0x00CC0020)
    DllCall("SelectObject", "ptr", mDC1, "ptr", oBM1)
    DllCall("SelectObject", "ptr", mDC2, "ptr", oBM2)
    DllCall("DeleteDC", "ptr", mDC1)
    DllCall("DeleteDC", "ptr", mDC2)
    DllCall("DeleteObject", "ptr", hBM)
    Return zhBM
}

Convert(sFileFr = "", sFileTo = "", nQuality = "")
{
    If (sFileTo = "")
        sFileTo := A_ScriptDir . "\screen.bmp"
    SplitPath, sFileTo, , sDirTo, sExtTo, sNameTo
    
    If Not hGdiPlus := DllCall("LoadLibrary", "str", "gdiplus.dll", "ptr")
        Return    sFileFr+0 ? SaveHBITMAPToFile(sFileFr, sDirTo (sDirTo = "" ? "" : "\") sNameTo ".bmp") : ""
    VarSetCapacity(si, 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", "UintP", pToken, "ptr", &si, "ptr", 0)

    If !sFileFr
    {
        DllCall("OpenClipboard", "ptr", 0)
        If    (DllCall("IsClipboardFormatAvailable", "Uint", 2) && (hBM:=DllCall("GetClipboardData", "Uint", 2, "ptr")))
            DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hBM, "ptr", 0, "ptr*", pImage)
        DllCall("CloseClipboard")
    }
    Else If    sFileFr Is Integer
        DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", sFileFr, "ptr", 0, "ptr*", pImage)
    Else    DllCall("gdiplus\GdipLoadImageFromFile", "wstr", sFileFr, "ptr*", pImage)
    DllCall("gdiplus\GdipGetImageEncodersSize", "UintP", nCount, "UintP", nSize)
    VarSetCapacity(ci,nSize,0)
    DllCall("gdiplus\GdipGetImageEncoders", "Uint", nCount, "Uint", nSize, "ptr", &ci)
    struct_size := 48+7*A_PtrSize, offset := 32 + 3*A_PtrSize, pCodec := &ci - struct_size
    Loop, %    nCount
        If InStr(StrGet(Numget(offset + (pCodec+=struct_size)), "utf-16") , "." . sExtTo)
            break

    If (InStr(".JPG.JPEG.JPE.JFIF", "." . sExtTo) && nQuality<>"" && pImage && pCodec < &ci + nSize)
    {
        DllCall("gdiplus\GdipGetEncoderParameterListSize", "ptr", pImage, "ptr", pCodec, "UintP", nCount)
        VarSetCapacity(pi,nCount,0), struct_size := 24 + A_PtrSize
        DllCall("gdiplus\GdipGetEncoderParameterList", "ptr", pImage, "ptr", pCodec, "Uint", nCount, "ptr", &pi)
        Loop, %    NumGet(pi,0,"uint")
            If (NumGet(pi,struct_size*(A_Index-1)+16+A_PtrSize,"uint")=1 && NumGet(pi,struct_size*(A_Index-1)+20+A_PtrSize,"uint")=6)
            {
                pParam := &pi+struct_size*(A_Index-1)
                NumPut(nQuality,NumGet(NumPut(4,NumPut(1,pParam+0,"uint")+16+A_PtrSize,"uint")),"uint")
                Break
            }
    }

    If pImage
        pCodec < &ci + nSize    ? DllCall("gdiplus\GdipSaveImageToFile", "ptr", pImage, "wstr", sFileTo, "ptr", pCodec, "ptr", pParam) : DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pImage, "ptr*", hBitmap, "Uint", 0) . SetClipboardData(hBitmap), DllCall("gdiplus\GdipDisposeImage", "ptr", pImage)

    DllCall("gdiplus\GdiplusShutdown" , "Uint", pToken)
    DllCall("FreeLibrary", "ptr", hGdiPlus)
}


CreateDIBSection(hDC, nW, nH, bpp = 32, ByRef pBits = "")
{
    VarSetCapacity(bi, 40, 0)
    NumPut(40, bi, "uint")
    NumPut(nW, bi, 4, "int")
    NumPut(nH, bi, 8, "int")
    NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")
    Return DllCall("gdi32\CreateDIBSection", "ptr", hDC, "ptr", &bi, "Uint", 0, "UintP", pBits, "ptr", 0, "Uint", 0, "ptr")
}

SaveHBITMAPToFile(hBitmap, sFile)
{
    VarSetCapacity(oi,104,0)
    DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
    fObj := FileOpen(sFile, "w")
    fObj.WriteShort(0x4D42)
    fObj.WriteInt(54+NumGet(oi,36+2*A_PtrSize,"uint"))
    fObj.WriteInt64(54<<32)
    fObj.RawWrite(&oi + 16 + 2*A_PtrSize, 40)
    fObj.RawWrite(NumGet(oi, 16+A_PtrSize), NumGet(oi,36+2*A_PtrSize,"uint"))
    fObj.Close()
}

SetClipboardData(hBitmap)
{
    VarSetCapacity(oi,104,0)
    DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
    sz := NumGet(oi,36+2*A_PtrSize,"uint")
    hDIB :=    DllCall("GlobalAlloc", "Uint", 2, "Uptr", 40+sz, "ptr")
    pDIB := DllCall("GlobalLock", "ptr", hDIB, "ptr")
    DllCall("RtlMoveMemory", "ptr", pDIB, "ptr", &oi + 16 + 2*A_PtrSize, "Uptr", 40)
    DllCall("RtlMoveMemory", "ptr", pDIB+40, "ptr", NumGet(oi, 16+A_PtrSize), "Uptr", sz)
    DllCall("GlobalUnlock", "ptr", hDIB)
    DllCall("DeleteObject", "ptr", hBitmap)
    DllCall("OpenClipboard", "ptr", 0)
    DllCall("EmptyClipboard")
    DllCall("SetClipboardData", "Uint", 8, "ptr", hDIB)
    DllCall("CloseClipboard")
}

CheckFullcrops() {
    ImageSearch,xx,yy,1743,264,1758,282,*120 C:\Users\aflhz\five.png
    If(Errorlevel=0) {
        return 5
    } else {
        return 4
    }


}


IsFullcrops(fullCropsNum) {
    If(fullCropsNum = 4) {
       ImageSearch,xx,yy,1723,262,1738,284,*100 C:\Users\aflhz\four.png
        If(Errorlevel=0) {
            return true
        } else {
            return false
        } 
    } else if(fullCropsNum = 5) {
       ImageSearch,xx,yy,1723,262,1738,284,*100 C:\Users\aflhz\five.png
        If(Errorlevel=0) {
            return true
        } else {
            return false
        } 
    
}

}


resourceLevUp() {
    ImageSearch,xx,yy,300,100,1700,630,*20 C:\Users\aflhz\plus.png
    If(Errorlevel=0) {
        MouseClick,left,xx+2,yy+2
    } else {
        
    }
    
    return
}

checkWelloperating() {
    
    errorTime := 0
    
    loop {
        
        if(errorTime > 22) {
            return false
        }
        

        loop {
            
            ImageSearch,xx,yy,1000,120,1150,180,*30 C:\Users\aflhz\operating3.png
            If(Errorlevel=0) {
                ;에러 발견
                Sleep,500
                errorTime := errorTime + 1
                if(errorTime >5) {
                    return false
                }
                
            } else {
                break
            }
        }
        
        
        /*
        loop {
            
            ImageSearch,xx,yy,735,275,870,350,*90 C:\Users\aflhz\operating4.png
            If(Errorlevel=0) {
                ;에러 발견
                Sleep,500
                errorTime := errorTime + 1
                if(errorTime >5) {
                    return false
                }
                
            } else {
                break
            }
        }
        
        
        */
        
        
        
        
        ImageSearch,xx,yy,1100,40,1200,120,*90 C:\Users\aflhz\operating.png
        If(Errorlevel=0) {
            Sleep,1000
            errorTime := 0
            return true
        } else {
            Sleep,1000
            errorTime := errorTime + 1
            result := false
        }
        
        ImageSearch,xx,yy,1100,40,1200,120,*90 C:\Users\aflhz\operating2.png
        If(Errorlevel=0) {
            Sleep,1000
            errorTime := 0
            return true
        } else {
            Sleep,1000
            errorTime := errorTime + 1
            result := false
        }
        
    }

    return false
}



reOperatingGame() {
    
    Sleep,1000
    MouseClick,left,591,20
    Sleep,2400
    MouseClick,left,1406,592
    Sleep,2400
    MouseClick,left,933,283
    Sleep,1000
    MouseClick,left,507,19
    Sleep,2400
    
    Sleep,45000
    errorTime := 0
    return 
}


CharacterChanging() {
		
        ;여기
		yamanNum := 0
        
		
        Sleep,1000
        MouseClick,left,143,94 ; 얼굴클릭
        Sleep,1000
                ;펭하아이디인지 확인 
        ImageSearch,xx,yy,778,546,833,600, *110 C:\Users\aflhz\penghi.png
		If(Errorlevel=0) {
			ifPenghi := 1
		} else {
            ifPenghi := 0
        }
        
        Sleep,1000
        MouseClick,left,1400,760 ; 설정클릭
        Sleep,1500
        MouseClick,left,463,553 ;캐릭터 관리 클릭
        Sleep,7000


        
        if (ifPenghi=0) {
            
            ImageSearch,xx,yy,280,330,340,380,*100 C:\Users\aflhz\check.png
            If(Errorlevel=0) {
				current_char_num := 1
				MouseClick,left,1200,320
                Sleep,1500
                MouseClick,left,1170,743
            } else {

		}
		
		ImageSearch,xx,yy,930,330,980,380,*100 C:\Users\aflhz\check.png
            If(Errorlevel=0) {
				current_char_num := 2
				MouseClick,left,635,519
                Sleep,1500
                MouseClick,left,1170,743
            } else {

		}
		
		ImageSearch,xx,yy,280,520,340,580,*100 C:\Users\aflhz\check.png
            If(Errorlevel=0) {
				current_char_num := 3
				MouseClick,left,1200,520
                Sleep,1500
                MouseClick,left,1170,743
            } else {

		}
		
		ImageSearch,xx,yy,930,520,990,580,*100 C:\Users\aflhz\check.png
            If(Errorlevel=0) {
				current_char_num := 4
				MouseClick,left,583,330
                Sleep,1500
                MouseClick,left,1170,743
            } else {

		}
        
        } else {
            ;펭하 아이디라면 
            
            ImageSearch,xx,yy,280,330,340,380,*100 C:\Users\aflhz\check.png
            If(Errorlevel=0) {
				current_char_num := 1
				MouseClick,left,1200,320
                Sleep,1500
                MouseClick,left,1170,743
            } else {
                current_char_num := 2
                MouseClick,left,583,330
                Sleep,1500
                MouseClick,left,1170,743
            }
            
            
        }
		

		
		
		hapNum := hapNum + 1
			
        
		Sleep,17000
        if (checkWelloperating() = false) {
            reOperatingGame()
        }
        
        
        
        idtimerNum := idtimerNum + 1
		return
        
}


IdChanging() {
	
    yamanNum := 0
	
    Sleep,1000
    MouseClick,left,120,83 ;얼굴클릭
    Sleep,1700
    
    
    
    
    MouseClick,left,1400,758 ;설정클릭
    Sleep,2000
    MouseClick,left,785,553
    Sleep,2000
    MouseClick,left,1100,660
    Sleep,3000
    MouseClick,left,940,612
    Sleep,4000
    
	loop {
		
		if(current_id_num=1) {
			MouseClick,left,635,558
			current_id_num := 2
            ifPenghi := 0
            
			break
		}
    
		if(current_id_num=2) {
			
            MouseMove,640,824
            Send {lbutton down}
            Sleep,300
            MouseMove,940,163,20
            send {lbutton up}
            Sleep,1000
            MouseClick,left,716,632
			current_id_num := 3
            ifPenghi := 1
            
			break
		}
        
        if(current_id_num=3) {
            MouseMove,640,824
            Send {lbutton down}
            Sleep,300
            MouseMove,940,163,20
            send {lbutton up}
            Sleep,1000
            MouseClick,left,707,730
            current_id_num := 4
            ifPenghi := 1
                
            
            break
        }
        
        if(current_id_num=4) {
            MouseClick,left,630,465
            current_id_num := 1
            ifPenghi := 0
            
            break
        }
	
	
	}
	

    
	
	
    Sleep,17000
    if (checkWelloperating() = false) {
        reOperatingGame()
    }
    
    return
    
}





ifError() {
    
    Sleep,2000
    MouseClick,left,593,21
    Sleep,2000
    MouseClick,left,931,283
    
        
    Sleep,50000
    
    if(checkWelloperating()=true) {
        return true
    } else if (checkWelloperating()=false) {
        Sleep,2000
        MouseClick,left,593,21
        Sleep,2000
        MouseClick,left,931,283
    

    }
    

    return
}

resourceChoice(resourceNum) {
    ;1옥수수
    ;2나무
    ;3돌
    ;4금화
    Random,randNum,4,6 ;자원지 레벨
    
    
    ;식량
    if(resourceNum<=3) {
      MouseClick,left,680,900  
      Sleep,500

      
      loop, 5 {
        MouseClick,left,484,593
        Sleep,70
        }
     
              
    ;펭하이면 자원지 렙업 ㄴㄴ 
    if(ifPenghi=1) {
        
        } else {
            
        loop, %randNum% {
            MouseClick,left,861,588
            Sleep,70
        }
    }
} 
;식량 요기까지 



;나무    
    if(resourceNum=3) {
      MouseClick,left,940,900  
      Sleep,500
      loop, 5 {
        MouseClick,left,746,593
        Sleep,80
     }
     
     
         ;펭하이면 자원지 렙업 ㄴㄴ 
    if(ifPenghi=1) {
        
        } else {
            
      loop, %randNum% {
        MouseClick,left,1124,588
        Sleep,80
     }
    }
} 

;나무 요기까지 
 
 
 
    ;돌
    if(resourceNum=4) {
      MouseClick,left,1200,900  
      Sleep,500
      loop, 5 {
        MouseClick,left,1018,593
        Sleep,80
     }
     
     
    ;펭하이면 자원지 렙업 ㄴㄴ 
    if(ifPenghi=1) {
        
        } else {
            
     loop, %randNum% {
        MouseClick,left,1389,588
        Sleep,80
     }
    }
} 
;돌 요기까지 
    
    
    ;금화 
    if(resourceNum>=5) {
      MouseClick,left,1470,900  
      Sleep,500
      loop, 5 {
        MouseClick,left,1273,593
        Sleep,200
     }
     
     
    ;펭하이면 자원지 렙업 ㄴㄴ 
    if(ifPenghi=1) {
        
        } else {
            
     loop, %randNum% {
        MouseClick,left,1647,588
        Sleep,100
     }
    }
} 

;금화 요기까지 


    
    Sleep,1000
    
    ImageSearch,xx,yy,553,651,1580,750,*40 C:\Users\aflhz\search.png
    If(Errorlevel=0) {
        MouseClick,left,xx+2,yy+2 ;검색 클릭
    } 

    return
    
}

CheckBuff() {
    Sleep,1000
    
    

    ImageSearch,xx,yy,1300,900,1368,987, *160 C:\Users\aflhz\item.png
    If(Errorlevel=0) {
        MouseClick,left,xx+6,yy+6 
    } else {
        MouseClick,left,1742,925
        Sleep,2000
        MouseClick,left,1340,939
    }
    
    
    
    Sleep,3000
    MouseClick,left,897,162
    Sleep,1000
    
    
    ;만약에 아이템창이 잘 열리지 않았다면 실행하지 않기 
    ImageSearch,xx,yy,1363,838,1443,885, *110 C:\Users\aflhz\using.png
    If(Errorlevel=0) {
        
    } else {
        return
    }
    
    
    
    
    ImageSearch,xx,yy,307,243,1146,928, *90 C:\Users\aflhz\buff.png
    If(Errorlevel=0) {
        MouseClick,left,xx+6,yy+6 ;삽클릭
        Sleep,1500
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
        errorTime := 0
    } 
    

    ;이미 버프 중이면 취소 
    ImageSearch,xx,yy,611,698,829,783, *50 C:\Users\aflhz\again.png
    If(Errorlevel=0) {
        SendInput,{esc}
        errorTime := 0
    } 
    
    Sleep,1000
    MouseMove,718,833
    Send {lbutton down}
    Sleep,300
    MouseMove,718,312,20
    send {lbutton up}
    
    
    MouseMove,718,833
    Send {lbutton down}
    Sleep,300
    MouseMove,718,312,20
    send {lbutton up}
    Sleep,1500
    
    ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\corn8h.png
    If(Errorlevel=0) {
        Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,2000
    } else {
        ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\corn24h.png
		Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    }
	
	Sleep,500
	;이미 버프 중이면 취소 
    ImageSearch,xx,yy,611,698,829,783, *50 C:\Users\aflhz\again.png
    If(Errorlevel=0) {
        SendInput,{esc}
    } 
	Sleep,500
	ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\stone8h.png
    If(Errorlevel=0) {
        Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    } else {
        ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\stone24h.png
		Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    }
	Sleep,500
	;이미 버프 중이면 취소 
    ImageSearch,xx,yy,611,698,829,783, *50 C:\Users\aflhz\again.png
    If(Errorlevel=0) {
        SendInput,{esc}
    } 
	Sleep,500
	    ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\gold8h.png
    If(Errorlevel=0) {
        Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    } else {
        ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\gold24h.png
		Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    }
	Sleep,500
	;이미 버프 중이면 취소 
    ImageSearch,xx,yy,611,698,829,783, *50 C:\Users\aflhz\again.png
    If(Errorlevel=0) {
        SendInput,{esc}
    } 
	Sleep,500
	    ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\tree8h.png
    If(Errorlevel=0) {
        Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    } else {
        ImageSearch,xx,yy,300,245,1137,932, *70 C:\Users\aflhz\tree24h.png
		Sleep,500
        MouseClick,left,xx+5,yy+5
        Sleep,1000
        MouseClick,left,1400,866 ; 확인
        Sleep,1500
    }
	
	Sleep,500
	;이미 버프 중이면 취소 
    ImageSearch,xx,yy,611,698,829,783, *50 C:\Users\aflhz\again.png
    If(Errorlevel=0) {
        SendInput,{esc}
    } 

    Sleep,1500
    
    ;창이 열여있어야 닫기 눌리기 
    ImageSearch,xx,yy,1363,838,1443,885, *110 C:\Users\aflhz\using.png
    If(Errorlevel=0) {
         Sleep,1000
        MouseClick,left,1581,155
        Sleep,1500
    } 

    
    return
    
}


GoToPlayer() {
    CoordMode,Pixel,Screen
    CoordMode,Mouse,Screen
    
    ImageSearch,xx,yy,630,1033,1175,1082,*100 C:\Users\aflhz\player.png

    If(Errorlevel=0) {
    
        ;플레이어 클릭
        MouseClick,left,xx+12,yy+12
        Sleep,2000
    }
    
    CoordMode,Mouse,Client
    CoordMode,Pixel,Client
    
    return
}

GoToKaKao() {
    
    
    CoordMode,Pixel,Screen
    CoordMode,Mouse,Screen

    ImageSearch,xx,yy,500,1030,1350,1072,*80 C:\Users\aflhz\kakao.png
    If(Errorlevel=0) {
        MouseClick,left,xx+12,yy+12
        Sleep,1000
        
        ImageSearch,x2,y2,500,840,1200,885,*100 C:\Users\aflhz\mykakao.png
        If(Errorlevel=0) {
            MouseClick,left,x2,y2
            errorTime := 0
        } else {

        }
			
		
        ;카카오 끊켰을때 에러처리 
        ImageSearch,x2,y2,0,0,1300,1300,*110 C:\Users\aflhz\kakaoerror.png
        If(Errorlevel=0) {
            
			
			Sleep,1000
			SendInput,{enter}

            Sleep,1500
            SendInput,rhdtjrdnjs1
			SendInput,{!}
            Sleep,600
            SendInput,{enter}
            Sleep,8500
			
			ImageSearch,x2,y2,0,0,1300,1300,*120 C:\Users\aflhz\me.png
			If(Errorlevel=0) {
			
			MouseClick,left,x2+4,y2+4
			Sleep,400
			MouseClick,left,x2+4,y2+4

            Sleep,1000
            WinMaximize, A
            errorTime := 0
			}
			
			
			
        } else {

        }
        
        
        
        
        
        
        
    } else {
       
    }

    WinMaximize, A

    CoordMode,Mouse,Client
    CoordMode,Pixel,Client

    return
}


WaitingSignal() {
       
    loop {
        
        Sleep,2000
    
       ImageSearch,xx,yy,1600,740,1900,900,*140 C:\Users\aflhz\start_signal.png
        If(Errorlevel=0) {
            
                ;클릭후확대
                MouseClick,left,xx,yy-150
                Sleep,2000
                WinMaximize, A
                Sleep,5000
                errorTime := 0
            
                return 1
        } else {
            Sleep,1000
            ImageSearch,xx,yy,1700,700,2000,960,*100 C:\Users\aflhz\re_signal.png
            If(Errorlevel=0) {
                
                GoToPlayer()
                
                
                ImageSearch,xx,yy,949,500,1473,588,*100 C:\Users\aflhz\start_click.png
                If(Errorlevel=0) {
                    ;만약 메크로 그림이 닫혔으면,
                    Sleep,1500
                    MouseClick,left, xx+15,yy+15
                    Sleep,4000
                    
                    SavePic()
                
                    GoToKaKao()
        
                    SendPic()
                    
                    
                } else {
                    
                    SavePic()
                
                    GoToKaKao()
        
                    SendPic()
                }
            }
        }
    }
    
    return 0

}


errorCheck() {

        ;인앱에서 중지되었습니다 라고 꺼질때
        ImageSearch,xx,yy,579,115,633,165,*90 C:\Users\aflhz\error1.png
        If(Errorlevel=0) {
            MouseClick,left,1407,595
            Sleep,2000
            MouseClick,left,936,293
            Sleep,7000
            
            if (checkWelloperating() = false) {
                reOperatingGame()
            }
        }
        
        /*
        ImageSearch,xx,yy,536,400,1400,760,*100 C:\Users\aflhz\error2.png
        If(Errorlevel=0) {
            MouseClick,left,927,692
            Sleep,10000
            
        }
        */
        
        /*
        ImageSearch,xx,yy,0,0,1200,1200,*100 C:\Users\aflhz\error3.png
        If(Errorlevel=0) {
            MouseClick,left,xx+4,yy+4
            Sleep,2000
            SendInput,rhdtjrdnjs1!
            Sleep,2000
            SendInput,{enter}
            Sleep,2000
            MouseClick,left,246,119
            Sleep,2000
            SendInput,공석원
            Sleep,2000
            MouseClick,left,207,188
            Sleep,300
            MouseClick,left,207,188
            Sleep,500
            GoToPlayer()
            Sleep,500
            
        }
        */
    
    
    
        
    return
}


SavePic(file_number := 1,file_extension := ".bmp") {

    Sleep,2000
    loop {
        file_name := file_number file_extension
    
        If FileExist(file_name) {
            ;MsgBox, "이미존재합니다." 
            file_name := file_number file_extension
            file_number := file_number+1
            
        } else {
            CaptureScreen("670,200,1200,870",0,file_name,"100")
            break
        }
    }
    
    
    return 1
}

SendPic() {
    
    Sleep,1000
    ;파일전송 클릭
    ImageSearch,xx,yy,0,800,1000,1200,*70 C:\Users\aflhz\sendpic.png
        If(Errorlevel=0) {
            
            MouseClick,left,500,500
            Sleep,500
         MouseClick,left,xx+12,yy+14
        } else {
        }
    Sleep,1500
    
    ;파일 보내기
    MouseClick,left,555,23
    Sleep,1000
    
    SendInput,C:\Users\aflhz
    Sleep,1000
    SendInput,{enter}
    Sleep,1000
    MouseClick,left,466,484
    Sleep,1000
    SendInput,%file_name%
    Sleep,1000
    SendInput,{enter}
    
    return 
}


ClickResource() {
    Sleep,1000
    ImageSearch,xx,yy,212,192,1640,880,*70 C:\Users\aflhz\clickGold.png
    If(Errorlevel=0) {
        Sleep,1600
        MouseClick,left,xx+3,yy+3
    }
    
    ImageSearch,xx,yy,212,192,1640,880,*70 C:\Users\aflhz\clickTree.png
    If(Errorlevel=0) {
        Sleep,1600
        MouseClick,left,xx+3,yy+3
    }
    
    ImageSearch,xx,yy,212,192,1640,880,*70 C:\Users\aflhz\clickCorn.png
    If(Errorlevel=0) {
        Sleep,1600
        MouseClick,left,xx+3,yy+3
    }
    
    ImageSearch,xx,yy,212,192,1640,880,*70 C:\Users\aflhz\clickStone.png
    If(Errorlevel=0) {
        Sleep,1600
        MouseClick,left,xx+3,yy+3
    }
    
    return
}



CheckMacro(mode) {
    ;mode 가 0이면 check 만해주고 mode 가 1면 클릭까지 진행  
    ImageSearch,xx,yy,1305,142,1622,282,*90 C:\Users\aflhz\start_macro.png
    If(Errorlevel=0) {
        if(mode=0) {
            return 0
        } else if (mode=1) {
             MouseClick,left,xx+15,yy+40
             Sleep,3000
        
            ImageSearch,xx,yy,949,500,1473,588,*120 C:\Users\aflhz\start_click.png
            If(Errorlevel=0) {
                MouseClick,left,xx+20,yy+20
                Sleep,5500
                
                ;디비에서 체크 
                
                if( comparePic()=true) {
                    if(compareCaptchaDB()=false) {
                        
                        SavePic()
                
                        GoToKaKao()
                
                        WinMaximize, A
                
                
                        SendPic()
                    }
                } else {
                    
                
                    SavePic()
                
                    GoToKaKao()
                
                    WinMaximize, A
                
                
                    SendPic()
                }
                
                
                
                
                
                
                
                
                return 1
            } 
            
            
        }
       
        
        
    } 
    
    return 0
}


comparePic() {
    
        
        Sleep,1000
        file_number := 1
        loop {
            
            file_name := file_number file_extension
            ImageSearch,xx,yy,500,100,1400,900,*110 C:\Users\aflhz\%file_name%
            If(Errorlevel=0) {
                return true
            } 
            
            If !FileExist(file_name) { 
                return false
            }
            
            file_number := file_number + 1
        }
       

    
    return
}





compareCaptchaDB() {
    
    
spilt := ","

ArrayMain := []  ;저장되는 배열 
Array_text_x := []  ;읽고나서 
Array_text_y := []
    
    
    
    ;text 숫자 읽어서 배열에 저장 
Loop, Read, C:\Users\aflhz\capchaDB.txt   
{
	    Loop, parse, A_LoopReadLine, %spilt%
    {
		
		ArrayCount += 1 
	
		ArrayMain%ArrayCount% := A_LoopField
	
    }
}

; 배열에 저장된 값 중 검색하여 찾는값 뽑아내기
Loop %ArrayCount%
{
	
	if(ArrayMain%A_Index% = file_name) {
		
		startIndex := A_Index
		
		hap := startIndex
		
		loop {
			hap := hap + 1
			if (ArrayMain%hap%="*") {
				endIndex := hap
				break
			}
		}

				indexNum := startIndex + 1

				hap := 0
				
				loop {
					
					if(indexNum=endIndex) {
						break
					}
				

					if( mod(indexNum,2) = 0) {
						Array_text_x[hap] := ArrayMain%indexNum%
					} else {
						hap := hap - 1
						Array_text_y[hap] := ArrayMain%indexNum%
					}
					indexNum := indexNum + 1
					hap := hap + 1
				}
		break
	} 


}


for index,value in Array_text_x,Array_text_y {
	MouseClick,left,Array_text_x[index],Array_text_y[index]
	Sleep,1000
}

    Sleep,1000
    MouseClick,left,1110,827  ; 확인버튼 
    Sleep,2000
    
    
    ;매크로 잘 풀렸나 확인
    ImageSearch,xx,yy,1044,802,1153,854, *110 C:\Users\aflhz\macroerror.png
    If(Errorlevel=0) {
        return false 
    } else {
        return true
    }
}


captchaSolve() {
    
    first_Click := 0xE53935
    second_Click :=0xFFA827
    third_Click := 0xD4E056
    forth_Click := 0x26A59A



    x_Array :=[]
    y_Array :=[]
    color_Array :=["0xE53935","0xFFA827","0xD4E056","0x26A59A"]
    
    
    

    For index,value in color_Array {
        PixelSearch,xx,yy,700,240,1215,757,value,10,FAST RGB
        if(ErrorLevel=0) {
        
            x_Array.Insert(index,xx-22)
            y_Array.Insert(index,yy+49)
            MouseMove,x_Array[index],y_Array[index]
            Sleep,300
            
        } else {
            
        }
    }
    
    WinClose,A
    
    GoToPlayer()

        
    ;chaptcha 좌표 찍기 
    For index,value in x_Array,y_Array {
        MouseClick,left,x_Array[index],y_Array[index]
    
        MouseMove,x_Array[index],y_Array[index]
        Sleep,300
    }

    ;확인버튼 눌리기
    MouseClick,left,1110,827 
    
    Sleep,2000
    
    ;메크로 잘 풀렸나 확인 
    
    ImageSearch,xx,yy,1044,802,1153,854, *110 C:\Users\aflhz\macroerror.png
    If(Errorlevel=0) {
        
        
        return false 
    } else {
        
        ;메모장에 파일 이름 , 좌표 저장 
        
        
        	FileAppend,
        (
			 %file_name%,
        ), C:\Users\aflhz\capchaDB.txt
	
	
	For index,value in x_Array,y_Array {
		FileAppend,
        (
			% x_Array[index]
        ),C:\Users\aflhz\capchaDB.txt
		
		FileAppend,
        (
			,
        ),C:\Users\aflhz\capchaDB.txt
		
		FileAppend,
        (
			% y_Array[index]
        ),C:\Users\aflhz\capchaDB.txt
		
		FileAppend,
        (
			,
        ),C:\Users\aflhz\capchaDB.txt
	}
	
	FileAppend,
        (
			  *`n
        ),C:\Users\aflhz\capchaDB.txt
	
	

        
    
       return true
    }
    
    
    return 1
}



;추가적인 기능들 

;연맹자원 먹기
getUnionResource() {
    
    ImageSearch,xx,yy,1300,900,1368,987, *160 C:\Users\aflhz\item.png
    If(Errorlevel=0) {
        Sleep,500
        MouseClick,left,1492,955 
        Sleep,500
    } else {
        Sleep,1000
        MouseClick,left,1742,925
        Sleep,1000
        MouseClick,left,1492,955 
        
    }
    
    Sleep,1500
    MouseClick,left,1269,598
    Sleep,1000
    MouseClick,left,1453,227
    Sleep,1000
    MouseClick,left,1592,101
    Sleep,500
    MouseClick,left,1592,101
    Sleep,1500
    
    return
}
 
;일쾌
dailyQuest() {
    
    Sleep,2000
    MouseClick,left,119,262
    Sleep,1500
    MouseClick,left,200,280
    Sleep,1500
	
    loop {
        ImageSearch,xx,yy,1352,487,1524,610,*90 C:\Users\aflhz\get.png   
        If(Errorlevel=0) {
            Sleep,800
            MouseClick,left,1432,583
            Sleep,800
		} else {
	
			MouseClick,left,200,467 
			Sleep,500
			break
		}
	
	}
    
    

    
    
    
		
		loop {
                ;창 닫기까지 다 포함 시키기
                
                
            ;보상 싹 받기 
            ImageSearch,xx,yy,1305,470,1528,536,*120 C:\Users\aflhz\get.png    
			If(Errorlevel=0) {
				Sleep,800
				MouseClick,left,1438,500
				Sleep,800
			} else {
                
            
                ;보상 한번 싸악 받기
                Sleep,1000
                MouseClick,left,550,310
                Sleep,1000
                MouseClick,left,623,153
                Sleep,1000
                MouseClick,left,780,310
                Sleep,1000
                MouseClick,left,623,153
                Sleep,1000
                MouseClick,left,1020,310
                Sleep,1000
                MouseClick,left,623,153
                Sleep,1000
                MouseClick,left,1250,310
                Sleep,1000
                MouseClick,left,623,153
                Sleep,1000
                MouseClick,left,1496,310
                Sleep,1000
                MouseClick,left,623,153
                Sleep,1000
                
                Sleep,800
                MouseClick,left,1556,149 ;창 닫기
                Sleep,1000

                
                ;아침 9시면 실행 
                if(A_Hour=9 && dailyNum =0) {
                    ;실행 
                    
     
                    
                    
                ;나무하나 심기
                Sleep,1000
                MouseClick,left,141,776
                Sleep,1000
                MouseClick,left,137,904
                Sleep,1000
                   
                ImageSearch,xx,yy,350,850,1230,910,*90 C:\Users\aflhz\tree2.png
                If(Errorlevel=0) {
                    MouseClick,left,xx,yy
                    Sleep,1500
                        
                    ImageSearch,xx,yy,240,190,1580,860,*90 C:\Users\aflhz\confirm.png
                    If(Errorlevel=0) {
                        MouseClick,left,xx+4,yy+4
                        Sleep,1500
                    }
                        
                }
                
                
                ;자원 1000따리 하나 먹기 
                
                
                ;해넘이
                
                
                ;사령관 경험치 맥이기 
                
                
                    
                    
                    
            ;아침 9시면 실행 종료         
            }

            Sleep,300
			break
		}
	
	}
    
    
  
		
    
    
    
return
    
} 
   
;야만인
Yaman() {
    
    ;펭하아이디면 당분간 야만인 X
    if(ifPenghi=1) {
        Sleep,1500
        yamanNum := 99
        return
    }
    
    
    Sleep,500
    MouseClick,left,149,923 ; 성나가기
    Sleep,1000
    MouseClick,left,139,782 ; 찾기
    Sleep,1000
	MouseClick,left,417,914 ; 야만인 클릭
	Sleep,1000
	
	;랩초기화
    loop, 10 {
        MouseClick,left,244,587
        Sleep,30
    }
    
    
    ;레벨 올리기
    loop, 7 {
        MouseClick,left,619,591
        Sleep,40
    }
    
    MouseClick,left,417,698 ; 찾기 클릭
    Sleep,900
	MouseClick,left,941,534 ; 가운대 클릭
    Sleep,600
    
    ;공격후 유지 풀기 
    ImageSearch,xx,yy,287,204,1589,848,*80 C:\Users\aflhz\check2.png   
        If(Errorlevel=0) {
            MouseClick,left,xx+4,yy+4
    }
    
    
	Sleep,800
    
     

    
    
    
    ;공격하기 
	ImageSearch,xx,yy,387,504,1489,848,*90 C:\Users\aflhz\attack.png   
        If(Errorlevel=0) {
            MouseClick,left,xx+30,yy+30
            Sleep,1000
            MouseClick,left,1437,236
            Sleep,1300
            
	} else {
        MouseClick,left,149,923
        yamanNum := 99
        Sleep,1000
        return
    }



 
         
        
        

        
       
        
        
        ImageSearch,xx,yy,1200,870,1430,950,*100 C:\Users\aflhz\clock.png
        If(Errorlevel=0) {
            ;만약에 행동력 포션 그림을 발견한다면 
            
            ;저장된 번호 1,2,3 눌리기 
            Sleep,700
            MouseClick,left,1570,400
            Sleep,400
            MouseClick,left,1570,481
            Sleep,400
            MouseClick,left,1570,557
            Sleep,400
            
            
            
            ;병력 없으면 증가시키기 
            loop {
                PixelSearch,xx,yy,1306,312,1311,317,0x10AA00,28,FAST RGB 
                if(ErrorLevel=0) {
                    ;병력이 충분하다면
                    
                    ;출전
                    MouseClick,left,1300,900 
                    Sleep,1000
                    break
                } else {
                    Sleep,300
                    MouseClick,left,1000,900
                    Sleep,300
                }
            }
                
            
            
            
            MouseClick,left,142,929 ;집으로 
            Sleep,14000
            
            yamanNum := yamanNum + 1
        } else {
            ;만약에 행동력 포션 그림을 발견하지 않는다면 
        
            MouseClick,left,600,600 ;아무곳이나 찍고 
            Sleep,1000
            MouseClick,left,142,929 ;집으로 
            Sleep,1300
            hap := Mod(chartimerNum,CHANGING_CHAR_NUM) - 1
            chartimerNum := chartimerNum + hap
            yamanNum := 99  
        }
    
    
          
        return
}
 
;역참
buyInStore() {
    
    Sleep,1000
    ImageSearch,xx,yy,270,200,1640,910, *110 C:\Users\aflhz\store.png
    If(Errorlevel=0) {
		MouseClick,left,xx+3,yy+3
		
		Sleep,1500
		
		
loop {
			
			ImageSearch,xx,yy,600,578,1490,630, *90 C:\Users\aflhz\storeTree.png
			If(Errorlevel=0) {
				MouseClick,left,xx+2,yy+2
			} else {
				Sleep,500
				ImageSearch,xx,yy,600,578,1490,630, *90 C:\Users\aflhz\storeCorn.png
				If(Errorlevel=0) {
					MouseClick,left,xx+2,yy+2
					Sleep,500
				} else {
					break
				}
			}
		
			
		
			Sleep,500
		}
		
		
		MouseMove,1058,881
		Send {lbutton down}
		Sleep,300
		MouseMove,1058,255,20
		send {lbutton up}
		
		MouseMove,1058,881
		Send {lbutton down}
		Sleep,300
		MouseMove,1058,255,20
		send {lbutton up}
		Sleep,1500

		
		loop, 2 {
			Sleep,500
			ImageSearch,xx,yy,605,511,1520,564, *90 C:\Users\aflhz\storeTree.png
			If(Errorlevel=0) {
                Random,randNum,1,3
                
                if (randNum = 3 ) {
                    MouseClick,left,xx+2,yy+2
                }
				
			} else {
				Sleep,500
				ImageSearch,xx,yy,605,511,1520,564, *90 C:\Users\aflhz\storeCorn.png
				If(Errorlevel=0) {
					Random,randNum,1,3
                
                    if (randNum = 3 ) {
                        MouseClick,left,xx+2,yy+2
                    }
					Sleep,500
				} else {
					break
				}
			}
		}
		
		Sleep,500
		
		ImageSearch,xx,yy,1400,227,1473,266, *90 C:\Users\aflhz\free.png
		If(Errorlevel=0) {
			
			MouseClick,left,xx+3,yy+3
			Sleep,1000
			loop {
			
			ImageSearch,xx,yy,600,578,1490,630, *90 C:\Users\aflhz\storeTree.png
			If(Errorlevel=0) {
				MouseClick,left,xx+2,yy+2
			} else {
				Sleep,500
				ImageSearch,xx,yy,600,578,1490,630, *90 C:\Users\aflhz\storeCorn.png
				If(Errorlevel=0) {
					MouseClick,left,xx+2,yy+2
					Sleep,500
				} else {
					break
				}
			}
		
			
		
			Sleep,500
		}
		
		
		MouseMove,1058,881
		Send {lbutton down}
		Sleep,300
		MouseMove,1058,255,20
		send {lbutton up}
		
		MouseMove,1058,881
		Send {lbutton down}
		Sleep,300
		MouseMove,1058,255,20
		send {lbutton up}
		Sleep,1500

		
		loop,2 {
			Sleep,500
			ImageSearch,xx,yy,605,511,1520,564, *90 C:\Users\aflhz\storeTree.png
			If(Errorlevel=0) {
				Random,randNum,1,3
                
                if (randNum = 3 ) {
                    MouseClick,left,xx+2,yy+2
                }
			} else {
				Sleep,500
				ImageSearch,xx,yy,605,511,1520,564, *90 C:\Users\aflhz\storeCorn.png
				If(Errorlevel=0) {
					Random,randNum,1,3
                
                    if (randNum = 3 ) {
                        MouseClick,left,xx+2,yy+2
                    }
					Sleep,500
				} else {
					break
				}
			}
		}
		
		Sleep,500
		} 	
        
        
        Sleep,500
        MouseClick,left,1564,151
        Sleep,1000
        
	}
    
    
    
	
	return
}


goToResource() {

        Sleep,1000
        MouseClick,left,142,929 ;성나가기
        Sleep,1000
        MouseClick,left,142,778 ;찾기 클릭
        Sleep,1300
        
        loop
        {
 
        Random, randNum, 1,6

        if randNum not in %hap%
            {
                break
            }
        }

        
        resourceChoice(randNum) ;자원 선택
        Sleep,1500
        
        hap := randNum
        
        MouseClick,left,930,530 ;자원지 클릭
        Sleep,1600
        
        MouseClick,left,1350,700 ;자원캐기 클릭
        Sleep,1000
        
        MouseClick,left,1430,230 ;병력 보내기 클릭
        Sleep,2000
        
        ;캐러갈 병력이 업다면 종료
        ImageSearch,xx,yy,1228,900,1270,940,*110 C:\Users\aflhz\fullcorps.png
        If(Errorlevel=0) {
            
            
            MouseClick,left,1593,97
            
            Sleep,2000
            
            
            MouseClick,left,142,929
            Sleep,1000
            
            
            
            
            hap := Mod(chartimerNum,CHANGING_CHAR_NUM) - 1
            chartimerNum := chartimerNum + hap
            
            return
        }
        
        
        
        
        Random,randNum,0,1
        
        if (randNum=0) {
           MouseClick,left,700,720 ;부사 뺴기
           Sleep,1000 
        }
        
        MouseClick,left,1320,900 ;행군하기 
        Sleep,1000 
        
        MouseClick,left,145,932 ;다시 마을로
        
        Sleep,5000
 
    return
}
 

createCorps() {
    
                unitNum := 500
               
                joojum_x := 498
                joojum_y := 498
                
                create1_x:= 1170
                create1_y:= 625
                
                create2_x:= 773
                create2_y:= 636
                
                create3_x:= 985
                create3_y:= 484
                
                create4_x:= 1160
                create4_y:= 360
				
				
				;한번 나갔다가 들어오기
				Sleep,1600
				MouseClick,left,147,941
				Sleep,1600
				MouseClick,left,147,941
                
                
                ;1번 생산
                Sleep,1800
                MouseClick,left,%create1_x%,%create1_y%
				Sleep,300
				MouseClick,left,%create1_x%,%create1_y%
                Sleep,1000

				x1 := create1_x + 194
				y2 := create1_y + 175
					
				MouseClick,left,%x1%,%y2% ;입장
				Sleep,1500
				
				PixelSearch,xx,yy,957,605,970,620,0x13DB00,35,FAST RGB 
                if(ErrorLevel=0) {
					;생산이 안되었다면 
					MouseClick,left,1460,614
					Sleep,800
					SendInput,%unitNum%
					Sleep,500
					SendInput,{enter}
					Sleep,500
					MouseClick,left,1408,850
					Sleep,1600
				} else {
					;생산하고 있다면
					MouseClick,left,1561,151 ; 닫기
				}
				
				
				
				
				;2번 생산
                Sleep,1000
                MouseClick,left,%create2_x%,%create2_y%
				Sleep,300
				MouseClick,left,%create2_x%,%create2_y%
                Sleep,1000

				x1 := create2_x + 194
				y2 := create2_y + 175
					
				MouseClick,left,%x1%,%y2% ;입장
				Sleep,1500
				
				PixelSearch,xx,yy,957,605,970,620,0x13DB00,35,FAST RGB 
                if(ErrorLevel=0) {
					;생산이 안되었다면 
					MouseClick,left,1460,614
					Sleep,800
					SendInput,%unitNum%
					Sleep,500
					SendInput,{enter}
					Sleep,500
					MouseClick,left,1408,850
					Sleep,1600
				} else {
					;생산하고 있다면
					MouseClick,left,1561,151 ; 닫기
				}
				
				;3번 생산
                Sleep,1000
                MouseClick,left,%create3_x%,%create3_y%
				Sleep,300
				MouseClick,left,%create3_x%,%create3_y%
                Sleep,1000

				x1 := create3_x + 194
				y2 := create3_y + 175
					
				MouseClick,left,%x1%,%y2% ;입장
				Sleep,1500
				
				PixelSearch,xx,yy,957,605,970,620,0x13DB00,35,FAST RGB 
                if(ErrorLevel=0) {
					;생산이 안되었다면 
					MouseClick,left,1460,614
					Sleep,800
					SendInput,%unitNum%
					Sleep,500
					SendInput,{enter}
					Sleep,500
					MouseClick,left,1408,850
					Sleep,1600
				} else {
					;생산하고 있다면
					MouseClick,left,1561,151 ; 닫기
				}
				
				
				
				;4번 생산
                Sleep,1000
                MouseClick,left,%create4_x%,%create4_y%
				Sleep,300
				MouseClick,left,%create4_x%,%create4_y%
                Sleep,1000

				x1 := create4_x + 194
				y2 := create4_y + 175
					
				MouseClick,left,%x1%,%y2% ;입장
				Sleep,1500
				
				PixelSearch,xx,yy,957,605,970,620,0x13DB00,35,FAST RGB 
                if(ErrorLevel=0) {
					;생산이 안되었다면 
					MouseClick,left,1460,614
					Sleep,800
					SendInput,%unitNum%
					Sleep,500
					SendInput,{enter}
					Sleep,500
                    MouseClick,left,930,300
					Sleep,500
					MouseClick,left,1408,850
					Sleep,1600
				} else {
					;생산하고 있다면
					MouseClick,left,1561,151 ; 닫기
				}

    return
}

jooJum() {
	
	location_x := 476
	location_y := 533
		
	x1 := location_x + 194
	y2 := location_y + 175
	
	Sleep,1000
    MouseClick,left,%location_x%,%location_y% ; 주점 위치
    Sleep,1000
    MouseClick,left,%x1%,%y2% ; 주점 위치
    Sleep,2000

    ;은열쇠의 무료 오픈이 있다면
    ImageSearch,xx,yy,580,846,651,889,*110 C:\Users\aflhz\open.png
    If(Errorlevel=0) {
        MouseClick,left,xx+13,yy+13
        Sleep,6000
        
        ;만약 사령관이 나왔다면
    loop {
        ImageSearch,xx,yy,258,835,379,909,*110 C:\Users\aflhz\open2.png
        If(Errorlevel=0) {
            MouseClick,left,xx+13,yy+13
			Sleep,2000
        } else {
            break
        }
    }
    
    ;은열쇠 오픈된거 닫기 
    ImageSearch,xx,yy,443,860,635,910,*110 C:\Users\aflhz\open2.png
        If(Errorlevel=0) {
            Sleep,2000
            MouseClick,left,xx+13,yy+13
        }
        
        Sleep,2000
    }
    
    ;금열쇠의 무료 오픈이 있다면
    ImageSearch,xx,yy,1258,844,1375,895,*110 C:\Users\aflhz\open.png
    If(Errorlevel=0) {
        MouseClick,left,xx+13,yy+13
        Sleep,6000
        
        
		;만약 사령관이 나왔다면
		loop {
        ImageSearch,xx,yy,258,835,379,909,*110 C:\Users\aflhz\open2.png
        If(Errorlevel=0) {
            Sleep,2000
            MouseClick,left,xx+13,yy+13
        } else {
            break
        }
    }
    
    ;금열쇠 오픈된거 닫기 
    ImageSearch,xx,yy,443,860,635,910,*110 C:\Users\aflhz\open2.png
        If(Errorlevel=0) {
            Sleep,2000
            MouseClick,left,xx+13,yy+13
        }



        } else {
        Sleep,1000
        MouseClick,left,113,91 ;나가기
    }
    
    Sleep,1000
    ;주점 안나갔으면 나가기 
    ImageSearch,xx,yy,1100,400,1500,650,*130 C:\Users\aflhz\joojumerror.png
    If(Errorlevel=0) {
        MouseClick,left,113,91 ;나가기
    }
    
    if (checkWelloperating() = false) {
                reOperatingGame()
    }
    
    Sleep,800
    return
}


F1::


file_number := 1
file_extension := ".bmp"
file_name := file_number file_extension
yamanNum := 0

chartimerNum := 1
idtimerNum := 1
currentidNum := 1 ;시작 아이디 



;메인함수

loop {
    

    
    loop, 170 {
        Sleep,17
        if ( CheckMacro(1) = 1) {
        loop {
            
            Sleep,1000
                
            
            if (WaitingSignal()=1) {
                
                
                    if(captchaSolve()=true) {
                        break
                    } else {
                        
                        SavePic()
                
                        GoToKaKao()
        
                        SendPic()
                    }

            }
            
            
            
        }
        
        }
    }
    
    
    
    if (checkWelloperating() = false) {
                reOperatingGame()
    }
    
    ;지원
    ImageSearch,xx,yy,116,190,1676,956,*90 C:\Users\aflhz\help.png
    If(Errorlevel=0) {
        MouseClick,left,xx+23,yy+36
        errorTime := 0
    } 
   
    
   
    ;캐릭터 및 아이디변경


    if(Mod(chartimerNum,CHANGING_CHAR_NUM) = 0) {
        
            yamanNum := 0

            ClickResource()
            
            jooJum()
            
            
            buyInStore()
            
            createCorps()
            
            Random,randNum,1,4
            
            if (randNum=1) {
                CheckBuff()
            }
            
            Random,randNum,1,2
            
            
            if (randNum=1) {
                getUnionResource()
            }
            
            Random,randNum,1,2
            if (randNum=1) {
                dailyQuest()
            }
            

            
            hap := CHANGING_CHAR_NUM * MAX_CHAR_NUM
            
            
            if(ifPenghi=0) {
                if(Mod(chartimerNum,hap) = 0) {
                    IdChanging()
                } else {
                    CharacterChanging()
                }
            } else {
                hap := CHANGING_CHAR_NUM * MAX_CHAR_NUM / 2
                if(Mod(chartimerNum,hap) = 0) {
                    IdChanging()
                } else {
                    CharacterChanging()
                }
            }
            

            
           
        
    
        } 
        
        


    
    
    
    ;풀병력이 아니면 
    if( !IsFullcrops(CheckFullcrops())) {
        
        
        loop {
        
        if(yamanNum > 3) {
            break
        } else {
            Yaman()
        }
        
    }
    
        
        
    
    
    buyInStore()
    
    

    errorCheck()
        
        
        
    if (checkWelloperating() = false) {
                reOperatingGame()
    }
        
        
        
        
        ;지원
        ImageSearch,xx,yy,116,190,1676,956,*90 C:\Users\aflhz\help.png
            If(Errorlevel=0) {
                MouseClick,left,xx+23,yy+36
                errorTime := 0
        } 
        

       
       ;자원캐러가기
       goToResource()
       
 
        
        errorCheck()
       
        if (checkWelloperating() = false) {
            reOperatingGame()
        }
       
       
       
         ;대기시간
        loop, 200 {
        Sleep,10
        if ( CheckMacro(1) = 1) {
            loop {
                Sleep,1000
            
            
                if (WaitingSignal()=1) {
                    if(captchaSolve()=true) {
                        break
                    } else {
                        
                        SavePic()
                
                        GoToKaKao()
        
                        SendPic()
                    }
                }
            }
        
        }
    }
       
    chartimerNum := chartimerNum + 1
    
    
    
    ;풀병력일 때에는 
    } else {
        
        ;연맹지원
        ImageSearch,xx,yy,116,190,1676,956,*90 C:\Users\aflhz\help.png
            If(Errorlevel=0) {
                MouseClick,left,xx+23,yy+36
                errorTime := 0
        } 
        
        
        
        if (checkWelloperating() = false) {
            reOperatingGame()
        }
        
        
        

        
        chartimerNum := chartimerNum + 1
        
        }
}



F2::
Reload


