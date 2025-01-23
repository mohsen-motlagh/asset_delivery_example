plugins {
            id("com.android.asset-pack")
        }

        assetPack {
            packName.set("video")
            dynamicDelivery {
                deliveryType.set("on-demand")
            }
        }