plugins {
            id("com.android.asset-pack")
        }

        assetPack {
            packName.set("catImage")
            dynamicDelivery {
                deliveryType.set("on-demand")
            }
        }