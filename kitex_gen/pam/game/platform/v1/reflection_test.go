package v1

import "testing"

func TestGeneratedReflectionContract(t *testing.T) {
	service := GetFileDescriptorForService()
	if service == nil {
		t.Fatal("service reflection descriptor is nil")
	}
	if method := service.GetMethodDescriptor("GamePlatformService", "CreateRoom"); method == nil {
		t.Fatal("CreateRoom reflection descriptor is missing")
	}

	acquire := GetFileDescriptorForAcquire()
	if acquire == nil {
		t.Fatal("acquire reflection descriptor is nil")
	}
	tempData := acquire.GetStructDescriptor("AcquireTempData")
	if tempData == nil {
		t.Fatal("AcquireTempData reflection descriptor is missing")
	}
	if field := tempData.GetFieldByName("merge_settle_current_player"); field == nil {
		t.Fatal("merge_settle_current_player reflection descriptor is missing")
	}
}
