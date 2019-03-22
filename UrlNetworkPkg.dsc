[Defines]
  PLATFORM_NAME                  = HpNetworkPkg
  PLATFORM_GUID                  = CEFBC0E5-8ED0-4c2c-AEDF-DF69A90E6489
  PLATFORM_VERSION               = 0.01
  DSC_SPECIFICATION              = 0x00010006
  OUTPUT_DIRECTORY               = Build/UrlNetworkPkg
  SUPPORTED_ARCHITECTURES        = IA32|X64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT

[PcdsFixedAtBuild]
  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0x0F
!if $(TARGET) != DEBUG
  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x80000000     ## DEBUG_ERROR
!endif

[LibraryClasses]
  #########################
  # Entry Point Libraries #
  #########################
  UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/UefiApplicationEntryPoint.inf
  UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf

  #########################
  # Debug Libraries       #
  #########################
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf                   ## No DEBUG
!if $(TARGET) == DEBUG
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf               ## DEBUG to ConOut (video is the default)
!endif

  ####################
  # Common Libraries #
  ####################
  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf

  UefiRuntimeLib|MdePkg/Library/UefiRuntimeLib/UefiRuntimeLib.inf

  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf
  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  LibNetUtil|StdLib/LibC/NetUtil/NetUtil.inf

  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  ShellLib|ShellPkg/Library/UefiShellLib/UefiShellLib.inf

  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  NetLib|MdeModulePkg/Library/DxeNetLib/DxeNetLib.inf

  ####################
  # HP Libraries     #
  ####################
  CurlLib|UrlNetworkPkg/Library/CurlLib/lib/CurlLib.inf
  #cjsonlib|MdePkg\Library\cJSON\cJSON.inf
  cJSON|UrlNetworkPkg/Library/CjsonLib/Lib/cJSON.inf
   IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
# CDYU 20170620 for SVID  
   PciLib|MdePkg/Library/BasePciLibCf8/BasePciLibCf8.inf
# try & error , compare to AppPkg.dsc  --> must exist
   PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf

[Components]
  #UrlNetworkPkg/Applications/simple/simple.inf
  #UrlNetworkPkg/Applications/gstore/gstore.inf
  #UrlNetworkPkg/Applications/url2file/url2file.inf
  #UrlNetworkPkg\Applications\sendheader\sendheader.inf
  #UrlNetworkPkg\Applications\TarArch\TarArch.inf
  #UrlNetworkPkg\Applications\SmbusMap\SmbusHierarchy.inf
  UrlNetworkPkg\Applications\FtpGet\ftpget.inf
  UrlNetworkPkg\Applications\FtpUpload\ftpupload.inf

!include StdLib/StdLib.inc

[BuildOptions.common]
   INTEL:*_*_*_CC_FLAGS = /Qdiag-disable:181,186
   MSFT:*_*_*_CC_FLAGS = /w  /Od /D_UEFI_ /DCURL_STATICLIB /DW4 /wd4127 /EHsc /FD /c /DBUILDING_LIBCURL /DALLOW_MSVC6_WITHOUT_PSDK
   GCC:*_*_*_CC_FLAGS = -O0 -D_UEFI_ -Wno-error

