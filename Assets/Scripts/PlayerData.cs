using System;
using UnityEngine;
using UnityEngine.Assertions.Must;
using static TagsAsStrings;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptable/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header("Statistics")] public static float health = 5f;

    public static readonly float rechargeTime = 10f;
    [NonSerialized] public static float boostCharge = 10f;

    public float highScore;

    [Header("Move")] [Range(4f, 12f)] public float maxSpeed = 10f;

    public float acceleration = 3f;
    
    private float _rechargeTimer;
    public bool ShieldIsLoaded { get; set; }


    
    
//Charges shield and booster
    public void RechargeTimer(){
        if (_rechargeTimer > 0f) {
            _rechargeTimer -= Time.deltaTime;
            boostCharge = Mathf.Lerp(boostCharge, 10f, 0.2f*Time.fixedDeltaTime);
        }
        else if (_rechargeTimer <= 0f) {
            _rechargeTimer = rechargeTime;
        }
    }
}