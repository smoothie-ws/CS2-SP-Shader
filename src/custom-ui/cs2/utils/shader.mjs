function protectSignalRetroAction(qmlComponent, fn) {
    return function() {
        var state = qmlComponent.state;
        if (state == "blockSignals") return;
        qmlComponent.state = "blockSignals";
        fn();
        qmlComponent.state = state;
    }
}

export class Shader {
    static connect(qmlComponent, propertyKey, shaderParameter) {
        qmlComponent[propertyKey] = shaderParameter.value;
        
        qmlComponent[propertyKey + "Changed"].connect(protectSignalRetroAction(qmlComponent, function() {
            shaderParameter.value = qmlComponent[propertyKey];
        }));
        shaderParameter.valueChanged.connect(protectSignalRetroAction(qmlComponent, function() {
            qmlComponent[propertyKey] = shaderParameter.value;
        }));
    }
}
