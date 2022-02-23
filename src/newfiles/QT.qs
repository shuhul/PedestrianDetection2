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
        for i in 0..0{
            use reg = Qubit[2];
            use data = Qubit();

            Rx(PI()/6.0, data);

            Message("Testing Quantum Teleporation Algorithm");

            DumpRegister((),[data]);

            QT(reg, data);

            DumpRegister((),[reg[1]]);

            Rx(-PI()/6.0, reg[1]);

            Message("Qubit Transfered Successfully");

            let outputM = MeasureAndMessage("Data", [reg[1]], false);

            //Message(BoolAsString(outputM[0] == false));



            ResetAll(reg + [data]);
	    }
    }

    //Quan

    @Test("QuantumSimulator")
    operation TestGenBellState () : Unit {
        for i in 0..0{
            use reg = Qubit[2];
            let dataInt = 2;
            let data = ReverseBoolArray(IntAsBoolArray(dataInt, 2));
            Message("Testing Bell State Generation");

            //Message(data[0] ? "true" | "false");
            //Message(data[1] ? "true" | "false");

            genBellState(reg, data);

            DumpRegister((), reg);

            Message("Bell State (|00> + |11>)/sqrt(2) Generated Successfully");

            let output = MeasureAndMessage("Reg", reg, false);


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
