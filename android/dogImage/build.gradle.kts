plugins {
            id("com.android.asset-pack")
        }

        assetPack {
            packName.set("dogImage")
            dynamicDelivery {
                deliveryType.set("on-demand")
            }
        }