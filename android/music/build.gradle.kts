plugins {
            id("com.android.asset-pack")
        }

        assetPack {
            packName.set("music")
            dynamicDelivery {
                deliveryType.set("on-demand")
            }
        }