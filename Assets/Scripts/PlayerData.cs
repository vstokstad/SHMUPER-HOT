using System;
using UnityEngine;
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
    private GameObject _shieldBubble;

    public bool ShieldIsLoaded {
        get => _shieldBubble.activeSelf;
        set => _shieldBubble.SetActive(value);
    }

    private void OnEnable(){
        _shieldBubble = GameObject.Find(shieldTag);
    }


//Charges shield and booster
    public void RechargeTimer(){
        if (_rechargeTimer > 0f) {
            _rechargeTimer -= Time.deltaTime;
            boostCharge = Mathf.Lerp(boostCharge, Mathf.Clamp(boostCharge, 0f, 10f), Time.deltaTime);
        }
        else if (_rechargeTimer <= 0f) {
            ShieldIsLoaded = true;
            _rechargeTimer = rechargeTime;
        }
    }
}