namespace Newfiles {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    open QSharpExercises;

    @Test("QuantumSimulator")
    operation TestQT () : Unit {
        for i in 0..10{
            use reg = Qubit[2];
            use data = Qubit();

            Rx(PI()/6.0, data);

            QT(reg, data);

            Rx(-PI()/6.0, reg[1]);

            let outputM = MeasureAndMessage("Data", [reg[1]], true);

            ResetAll(reg + [data]);
	    }
    }

    //Quan

    @Test("QuantumSimulator")
    operation TestGenBellState () : Unit {
        for i in 0..10{
            use reg = Qubit[2];
            let dataInt = 2;
            let data = ReverseBoolArray(IntAsBoolArray(dataInt, 2));
            Message(data[0] ? "true" | "false");
            Message(data[1] ? "true" | "false");

            genBellState(reg, data);

            let output = MeasureAndMessage("Reg", reg, true);

            ResetAll(reg);
	    }
    }

    //Quantum teleportation algorithm
    operation QT (reg : Qubit[], data : Qubit) : Unit {
        genBellState(reg, [false, false]);
        CX(data, reg[0]);
        H(data);
        let bits = MultiM([data, reg[0]]);
        if(bits[0] == One){
            Z(reg[1]);
        }
        if(bits[1] == One){
            X(reg[1]);
        }
    }

    operation genBellState (input : Qubit[] , num : Bool[] ): Unit{
        H(input[0]);
        CX(input[0], input[1]);
        if(num[0]){
            Z(input[0]);
        }
        if(num[1]){
            X(input[1]);
        }
    } 
}
