import QtQuick 2.0
import QtGraphicalEffects 1.0

Image {
    id: colorImage
    property color color
    layer.enabled: true
    layer.effect: ColorOverlay {
        color: colorImage.color
    }
}
